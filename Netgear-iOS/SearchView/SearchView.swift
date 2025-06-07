//
//  SearchView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct SearchView<ViewModel: SearchViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                        Text("Lookng for books…")
                    }
                    .foregroundStyle(.secondary)
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
                    List(viewModel.books) { book in
                        SearchResultRow(book: book)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Harry Potter, Stephen King…"))
            .onSubmit(of: .search) {
                Task { await viewModel.search() }
            }
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
