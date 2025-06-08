//
//  ListView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct ListView: View {
    @Namespace private var namespace

    let books: [BookViewModel]

    var body: some View {
        List {
            ForEach(books) { book in
                NavigationLink {
                    BookDetailView(viewModel: book)
                        .navigationTransition(.zoom(sourceID: book.id, in: namespace))
                } label: {
                    SearchResultRow(viewModel: book)
                        .matchedTransitionSource(id: book.id, in: namespace)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListView(books: [
        .init(book: .common)
    ])
}
