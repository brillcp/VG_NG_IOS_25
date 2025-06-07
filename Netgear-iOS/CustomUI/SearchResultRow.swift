//
//  SearchResultRow.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct SearchResultRow: View {
    let book: Book

    var smallThumbnail: URL? {
        URL(string: book.volumeInfo.imageLinks?.smallThumbnail ?? "")
    }

    var body: some View {
        HStack {
            AsyncImage(url: smallThumbnail) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 64.0, height: 64.0)

            VStack(alignment: .leading) {
                Text(book.volumeInfo.title)
                    .bold()
                Text(book.volumeInfo.authors.first ?? "")
                Text(book.volumeInfo.categories?.first ?? "")
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
            Spacer()
        }
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
    SearchResultRow(book: .init(id: "id", volumeInfo: volume))
}
