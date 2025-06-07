//
//  BookDetailView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookDetailView: View {
    let book: BookViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32.0) {
                AsyncBookImage(book: book)
                    .frame(width: 160.0, height: 240.0)
                    .clipShape(RoundedRectangle.bookCornerRadius)

                VStack {
                    Text(book.volumeInfo.title)
                        .font(.title2.bold())
                    Text(book.volumeInfo.authors?.first ?? "")
                }
            }
            
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.callout.bold())
                Text(book.volumeInfo.description ?? "")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
            }
            .padding(.top, 32.0)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let volume = VolumeInfo(
        title: "title",
        subtitle: "subtitle",
        authors: ["author"],
        publisher: "publisher",
        publishedDate: "",
        description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
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

    BookDetailView(book: .init(book: .init(id: "id", volumeInfo: volume)))
}
