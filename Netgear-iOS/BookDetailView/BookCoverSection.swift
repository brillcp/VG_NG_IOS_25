//
//  BookCoverSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookCoverSection: View {
    let book: BookViewModel
    
    private var volumeInfo: VolumeInfo {
        book.volumeInfo
    }

    var body: some View {
        VStack(spacing: 16) {
            AsyncBookImage(book: book)
                .frame(width: 160, height: 240)
                .clipShape(RoundedRectangle.bookCornerRadius)
                .padding(.top)

            VStack(spacing: 8) {
                Text(volumeInfo.title)
                    .font(.title2.bold())

                if let author = volumeInfo.authors?.first {
                    Text(author)
                }

                if let subtitle = volumeInfo.subtitle {
                    Text(subtitle)
                        .font(.caption.italic())
                }

                if let category = volumeInfo.categories?.first {
                    Text(category)
                }

                BookMetadataSection(book: book)
                    .padding(.top)
            }
            .multilineTextAlignment(.center)
            .foregroundStyle(book.color.isDark ? .white : .black)
            .padding()
        }
        .background(book.color)
    }
}

#Preview {
    BookCoverSection(book: .init(book: .init(id: "id", volumeInfo: .common)))
}
