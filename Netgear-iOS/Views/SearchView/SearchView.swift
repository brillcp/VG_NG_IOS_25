//
//  SearchView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct SearchView<ViewModel: SearchViewModelProtocol>: View {
    @State private var displayMode: DisplayMode = .page
    @State private var selectedPage = 0

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            VStack {
                displayToggle
                Divider()
                contentView
            }
            .navigationTitle("Search")
            .searchable(
                text: $viewModel.query,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("Harry Potter, Stephen King…")
            )
            .onChange(of: viewModel.query, viewModel.clearSearch)
            .onSubmit(of: .search, performSearch)
            .animation(.default, value: displayMode)
            .alert("Search Error", isPresented: .constant(viewModel.searchState.isError)) {
                Button("OK", action: viewModel.dismissError)
            } message: {
                Text(viewModel.searchState.errorMessage ?? "An unknown error occurred")
            }
        }
    }
}

// MARK: - Display Mode
extension SearchView {
    enum DisplayMode {
        case list, page

        var icon: String {
            switch self {
            case .list: "rectangle.portrait.on.rectangle.portrait"
            case .page: "list.bullet"
            }
        }

        var toggled: DisplayMode {
            switch self {
            case .list: .page
            case .page: .list
            }
        }
    }
}

// MARK: - View Components
private extension SearchView {
    var displayToggle: some View {
        HStack(spacing: 16) {
            Spacer()
            Button(action: toggleDisplayMode) {
                Image(systemName: displayMode.icon)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    @ViewBuilder
    var contentView: some View {
        switch viewModel.searchState {
        case .idle:
            IdleView()
        case .searching:
            LoadingView()
        case .loaded(let books):
            if books.isEmpty {
                Text("no books…")
            } else {
                booksDisplayView(books: books)
            }
        case .failed:
            IdleView()
        }
    }

    @ViewBuilder
    func booksDisplayView(books: [BookViewModel]) -> some View {
        switch displayMode {
        case .list:
            ListView(books: books)
        case .page:
            PageView(
                books: books,
                selectedPage: $selectedPage
            )
        }
    }
}

// MARK: - Actions
private extension SearchView {
    func toggleDisplayMode() {
        displayMode = displayMode.toggled
    }

    func performSearch() {
        Task {
            await viewModel.search()
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
