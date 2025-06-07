//
//  SearchResultRow.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct SearchResultRow: View {
    let book: BookViewModel

    private var volumeInfo: VolumeInfo {
        book.volumeInfo
    }

    var body: some View {
        HStack {
            AsyncBookImage(book: book)
                .frame(width: 64.0, height: 64.0)

            VStack(alignment: .leading) {
                Text(volumeInfo.title)
                    .bold()
                Text(volumeInfo.authors?.first ?? "")
                Text(volumeInfo.categories?.first ?? "")
                    .foregroundStyle(.secondary)
                
            }
            .font(.caption)
            Spacer()
            
            if let amount = volumeInfo.saleInfo?.retailPrice?.amount, let currency = volumeInfo.saleInfo?.retailPrice?.currencyCode {
                Text("\(amount) \(currency)")
            }
        }
    }
}

#Preview {
    SearchResultRow(book: .init(book: .init(id: "id", volumeInfo: .common)))
}
