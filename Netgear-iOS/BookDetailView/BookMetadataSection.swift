//
//  BookMetadataSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookMetadataSection: View {
    let book: BookViewModel
    
    var volumeInfo: VolumeInfo {
        book.volumeInfo
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let type = volumeInfo.printType {
                Text(type)
            }

            HStack {
                if let language = volumeInfo.language {
                    Text("\(language)")
                }
                if let date = volumeInfo.publishedDate {
                    Text("· \(date)")
                }
                if let pageCount = volumeInfo.pageCount {
                    Text("· \(pageCount) pages")
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16.0)
                .fill((book.color.isDark ? Color.white : Color.black).opacity(0.2))
        )
        .padding(.horizontal)
    }
}

#Preview {
    BookMetadataSection(book: .init(book: .init(id: "id", volumeInfo: .common)))
}
