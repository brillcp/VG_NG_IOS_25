//
//  SearchView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct SearchView<ViewModel: SearchViewModelProtocol>: View {
    @Namespace private var namespace

    @State private var displayMode: DisplayMode = .page
    @State private var selectedPage = 0

    @ObservedObject var viewModel: ViewModel

    enum DisplayMode {
        case list, page
    }

    var body: some View {
        NavigationStack {
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
            Spacer()
            Button {
                switch displayMode {
                case .list:
                    displayMode = .page
                case .page:
                    displayMode = .list
                }
            } label: {
                Image(systemName: displayMode == .list ?  "rectangle.portrait.on.rectangle.portrait.angled" : "list.bullet")
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
