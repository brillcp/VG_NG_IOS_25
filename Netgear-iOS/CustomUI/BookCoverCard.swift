//
//  PageDetailView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookCoverCard: View {
    @ObservedObject var book: BookViewModel

    var body: some View {
        VStack(spacing: 24.0) {
            AsyncBookImage(book: book)
                .frame(width: 160.0, height: 240.0)
                .clipShape(RoundedRectangle.bookCornerRadius)

            Text(book.volumeInfo.title)
                .font(.title2.bold())
        }
        .padding(32.0)
        .foregroundStyle(.black)
    }
}

#Preview {
    BookCoverCard(book: .init(book: .common))
}
