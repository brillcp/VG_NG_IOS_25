//
//  AsyncBookImage.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct AsyncBookImage: View {
    @ObservedObject var book: BookViewModel

    var body: some View {
        Group {
            if let data = book.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        ProgressView()
                    }
            }
        }
        .clipShape(RoundedRectangle.bookCornerRadius)
        .task(book.loadThumbnail)
    }
}

#Preview {
    AsyncBookImage(book: .init(book: .common))
}
