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
            BookCoverSection(book: book)

            if let description = volumeInfo.description {
                BookDescriptionSection(
                    title: "Description",
                    subtitle: description
                )
                .padding(.top)
            }

            if let snippet = book.searchInfo?.textSnippet {
                BookDescriptionSection(
                    title: "Snippet",
                    subtitle: snippet
                )
            }

            if let publisher = volumeInfo.publisher {
                BookDescriptionSection(
                    title: "Publisher",
                    subtitle: publisher
                )
            }
        }
    }
}

// MARK: -
private extension BookDetailView {
    var volumeInfo: VolumeInfo {
        book.volumeInfo
    }
}

#Preview {
    BookDetailView(book: .init(book: .common))
}
