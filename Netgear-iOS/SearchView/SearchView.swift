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

    enum DisplayMode {
        case list, page
    }

    var body: some View {
        NavigationView {
            VStack {
                displayToggle
                Divider()

                if viewModel.isLoading {
                    LoadingView()
                } else if viewModel.books.isEmpty {
                    IdleView()
                } else {
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
            .navigationTitle("Search")
            .searchable(
                text: $viewModel.query,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("Harry Potter, Stephen King…")
            )
            .onSubmit(of: .search) {
                Task { await viewModel.search() }
            }
        }
    }
}

// MARK: -
private extension SearchView {
    var displayToggle: some View {
        HStack(spacing: 16) {
            Button {
                displayMode = .page
            } label: {
                Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    .foregroundStyle(displayMode == .page ? .primary : .secondary)
                    .font(displayMode == .page ? .headline : .body)
            }
            Button {
                displayMode = .list
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundStyle(displayMode == .list ? .primary : .secondary)
                    .font(displayMode == .list ? .headline : .body)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
