//
//  BookCoverSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookCoverSection: View {
    let book: BookViewModel

    var body: some View {
        VStack(spacing: 16) {
            AsyncBookImage(book: book)
                .frame(width: 160, height: 240)
                .clipShape(RoundedRectangle.bookCornerRadius)

            VStack(spacing: 8) {
                Text(volumeInfo.title)
                    .font(.title2.bold())

                if let author = volumeInfo.authors?.first {
                    Text(author)
                }

                if let category = volumeInfo.categories?.first {
                    Text(category)
                }

                if let subtitle = volumeInfo.subtitle {
                    Text(subtitle)
                        .font(.caption.italic())
                }

                BookMetadataSection(book: book)
                    .padding(.top)
            }
            .foregroundStyle(book.color.isDark ? .white : .black)
            .multilineTextAlignment(.center)
        }
        .padding()
        .background(book.color)
    }
}

// MARK: -
private extension BookCoverSection {
    var volumeInfo: VolumeInfo {
        book.volumeInfo
    }
}

#Preview {
    BookCoverSection(book: .init(book: .common))
}
