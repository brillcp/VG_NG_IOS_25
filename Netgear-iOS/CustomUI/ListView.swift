//
//  ListView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct ListView: View {
    let books: [Book]

    var body: some View {
        List {
            ForEach(books) { book in
                NavigationLink {
                    BookDetailView(book: book)
                } label: {
                    SearchResultRow(book: book)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    let volume = VolumeInfo(
        title: "title",
        authors: ["author"],
        publisher: nil,
        publishedDate: nil,
        description: nil,
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

    ListView(books: [.init(id: "id", volumeInfo: volume)])
}
