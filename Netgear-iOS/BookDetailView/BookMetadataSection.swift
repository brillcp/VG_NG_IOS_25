//
//  BookMetadataSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookMetadataSection<ViewModel: BookViewModelProtocol>: View {
    let viewModel: ViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16.0) {
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

                HStack {
                    navLink(
                        title: "Preview",
                        url: viewModel.accessInfo?.webReaderLink
                    )
                    .buttonStyle(.bordered)

                    navLink(
                        title: "Buy \(viewModel.priceString ?? "")",
                        url: viewModel.saleInfo?.buyLink
                    )
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16.0)
                    .fill((viewModel.color.isDark ? Color.white : Color.black).opacity(0.2))
            )
        }
    }
}

// MARK: -
private extension BookMetadataSection {
    var volumeInfo: VolumeInfo {
        viewModel.volumeInfo
    }

    func navLink(title: String, url: String?) -> some View {
        NavigationLink {
            if let url = URL(string: url) {
                WebView(url: url)
            }
        } label: {
            HStack {
                Spacer()
                Text(title)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .disabled(url == nil)
    }
}

#Preview {
    BookMetadataSection(viewModel: BookViewModel(book: .common))
}
