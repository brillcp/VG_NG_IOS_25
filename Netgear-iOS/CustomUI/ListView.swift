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
                    BookDetailView(book: book)
                        .navigationTransition(.zoom(sourceID: book.id, in: namespace))
                } label: {
                    SearchResultRow(book: book)
                        .matchedTransitionSource(id: book.id, in: namespace)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    let volume = VolumeInfo(
        title: "title",
        subtitle: "subtitle",
        authors: ["author"],
        publisher: "publisher",
        publishedDate: "",
        description: "description",
        industryIdentifiers: nil,
        readingModes: nil,
        pageCount: nil,
        printType: nil,
        categories: ["comedy"],
        maturityRating: nil,
        allowAnonLogging: nil,
        contentVersion: nil,
        panelizationSummary: nil,
        imageLinks: .init(smallThumbnail: "http://books.google.com/books/content?id=3ikDEAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api", thumbnail: "http://books.google.com/books/content?id=3ikDEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"),
        language: nil,
        previewLink: nil,
        infoLink: nil,
        canonicalVolumeLink: nil
    )

    ListView(books: [.init(book: .init(id: "id", volumeInfo: volume))])
}
