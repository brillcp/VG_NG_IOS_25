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
                    Text(book.volumeInfo.subtitle ?? "")
                        .font(.caption.italic())
                        .multilineTextAlignment(.leading)
                }
            }
            VStack(alignment: .leading) {
                Text("Book")
                Text("\(book.volumeInfo.language ?? "das") · \(book.volumeInfo.publishedDate ?? "22")")
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(.red)
            )
            .padding()

            VStack(alignment: .leading) {
                Text("From the publisher")
                    .font(.footnote.bold())
                Text(book.volumeInfo.description ?? "")
                    .font(.caption.italic())
                    .multilineTextAlignment(.leading)
            }
            .padding(.top, 32.0)

            Divider()
        }
        .padding(.horizontal)
    }
}

#Preview {
    BookDetailView(book: .init(book: .init(id: "id", volumeInfo: .common)))
}
