//
//  BookCoverSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookCoverSection<ViewModel: BookViewModelProtocol>: View {
    let viewModel: ViewModel

    var body: some View {
        VStack(spacing: 16) {
            AsyncBookImage(viewModel: viewModel)
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

                BookMetadataSection(viewModel: viewModel)
                    .padding(.top)
            }
            .foregroundStyle(viewModel.color.isDark ? .white : .black)
            .multilineTextAlignment(.center)
        }
        .padding()
        .background(viewModel.color)
    }
}

// MARK: -
private extension BookCoverSection {
    var volumeInfo: VolumeInfo {
        viewModel.volumeInfo
    }
}

#Preview {
    BookCoverSection(viewModel: BookViewModel(book: .common))
}
