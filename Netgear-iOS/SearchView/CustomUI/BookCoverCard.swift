//
//  PageDetailView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookCoverCard: View {
    let book: Book

    var thumbnailURL: URL? {
        URL(string: book.volumeInfo.imageLinks?.thumbnail ?? "")
    }

    var body: some View {
        VStack(spacing: 24.0) {
            AsyncImage(url: thumbnailURL) { image in
                image
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fill)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .tint(.white)
            }
            .frame(width: 250, height: 140)
            .background(Color(.systemGray3))
            .clipShape(RoundedRectangle(cornerRadius: 16.0))

            Text(book.volumeInfo.title)
                .font(.title2.bold())
        }
        .padding(32.0)
        .foregroundStyle(.black)
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

    BookCoverCard(book: .init(id: "id", volumeInfo: volume))
}
