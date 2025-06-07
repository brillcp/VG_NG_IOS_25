//
//  BookMetadataSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookMetadataSection: View {
    let book: BookViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let type = volumeInfo.printType {
                Text(type.capitalized)
            }

            HStack(spacing: 16.0) {
                if let language = volumeInfo.language {
                    Label("\(language)", systemImage: "character.book.closed.fill")
                }
                if let date = volumeInfo.publishedDate {
                    Label("\(date)", systemImage: "calendar")
                }
                if let pageCount = volumeInfo.pageCount {
                    Label("\(pageCount)", systemImage: "book.pages.fill")
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16.0)
                .fill((book.color.isDark ? Color.white : Color.black).opacity(0.2))
        )
    }
}

// MARK: -
private extension BookMetadataSection {
    var volumeInfo: VolumeInfo {
        book.volumeInfo
    }
}

#Preview {
    BookMetadataSection(book: .init(book: .init(id: "id", volumeInfo: .common)))
}
