//
//  BookDescriptionSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookDescriptionSection: View {
    let volumeInfo: VolumeInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let description = volumeInfo.description {
                Text("Description")
                    .font(.footnote.bold())

                Text(description)
                    .font(.caption.italic())
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
#Preview {
    BookDescriptionSection(volumeInfo: .common)
}
