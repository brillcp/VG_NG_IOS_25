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
                    VStack {
                        ProgressView()
                        Text("Looking for books…")
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.books.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "book.circle")
                            .font(.system(size: 64))
                            .fontWeight(.thin)
                        Text("Find books and authors")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.secondary)
                } else {
                    switch displayMode {
                    case .list:
                        List {
                            ForEach(viewModel.books) { book in
                                NavigationLink {
                                    Text(book.volumeInfo.description ?? "")
                                        .padding()
                                } label: {
                                    SearchResultRow(book: book)
                                }
                            }
                        }
                        .listStyle(.plain)
                    case .page:
                        TabView(selection: $selectedPage) {
                            ForEach(Array(viewModel.books.enumerated()), id: \.element.id) { index, book in
                                NavigationLink {
                                    Text(book.volumeInfo.description ?? "")
                                        .padding()
                                } label: {
                                    Text(book.volumeInfo.description ?? "")
                                }
                                .tag(index)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
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
