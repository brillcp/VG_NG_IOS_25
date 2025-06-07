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
            BookCoverSection(book: book)
            BookDescriptionSection(volumeInfo: volumeInfo)
            Divider()
                .padding(.horizontal)
        }
    }
}

#Preview {
    BookDetailView(book: .init(book: .init(id: "id", volumeInfo: .common)))
}
