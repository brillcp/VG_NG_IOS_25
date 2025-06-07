//
//  BookDetailView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookDetailView: View {
    private var volumeInfo: VolumeInfo {
        book.volumeInfo
    }

    let book: BookViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32.0) {
                AsyncBookImage(book: book)
                    .frame(width: 160.0, height: 240.0)
                    .clipShape(RoundedRectangle.bookCornerRadius)
                    .frame(maxWidth: .infinity)
                VStack(spacing: 8) {
                    Text(volumeInfo.title)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                    Text(volumeInfo.authors?.first ?? "")
                    Text(volumeInfo.subtitle ?? "")
                        .font(.caption.italic())
                        .multilineTextAlignment(.center)
                    Text(volumeInfo.categories?.first ?? "")
                }
                .padding()

                VStack(alignment: .leading) {
                    Text(volumeInfo.printType ?? "Book")
                    Text("\(volumeInfo.language ?? "en") · \(volumeInfo.publishedDate ?? "22") · \(volumeInfo.pageCount ?? 0) pages")
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16.0)
                        .fill((book.color.isDark ? Color.white : Color.black).opacity(0.2))
                )
                .padding()
            }
            .foregroundStyle(book.color.isDark ? .white : .black)
            .padding(.vertical)
            .background(book.color)

            VStack(alignment: .leading) {
                Text("From the publisher")
                    .font(.footnote.bold())
                Text(volumeInfo.description ?? "")
                    .font(.caption.italic())
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

            Divider()
                .padding(.horizontal)
        }
    }
}

#Preview {
    BookDetailView(book: .init(book: .init(id: "id", volumeInfo: .common)))
}
