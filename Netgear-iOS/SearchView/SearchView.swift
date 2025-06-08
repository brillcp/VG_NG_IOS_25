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
            .onSubmit(of: .search, performSearch)
            .animation(.default, value: displayMode)
        }
    }
}

// MARK: - Display Mode
extension SearchView {
    enum DisplayMode {
        case list, page

        var icon: String {
            switch self {
            case .list: return "rectangle.portrait.on.rectangle.portrait"
            case .page: return "list.bullet"
            }
        }

        var toggled: DisplayMode {
            switch self {
            case .list: return .page
            case .page: return .list
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
        if viewModel.isLoading {
            LoadingView()
        } else if viewModel.books.isEmpty {
            IdleView()
        } else {
            booksDisplayView
        }
    }

    @ViewBuilder
    var booksDisplayView: some View {
        switch displayMode {
        case .list:
            ListView(books: viewModel.books)
        case .page:
            PageView(
                books: viewModel.books,
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
