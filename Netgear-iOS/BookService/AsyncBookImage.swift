//
//  AsyncBookImage.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct AsyncBookImage<ViewModel: BookViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Group {
            if let data = viewModel.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        ProgressView()
                            .tint(.gray)
                    }
            }
        }
        .clipShape(RoundedRectangle.bookCornerRadius)
        .task(viewModel.loadThumbnail)
    }
}

#Preview {
    AsyncBookImage(viewModel: BookViewModel(book: Book.common))
        .frame(width: 160.0, height: 240.0)
}
