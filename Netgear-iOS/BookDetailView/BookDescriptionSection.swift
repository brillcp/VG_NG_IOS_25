//
//  BookDescriptionSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookDescriptionSection: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .bold()

            Text(subtitle)
                .font(.caption.italic())
                .multilineTextAlignment(.leading)

            Divider()
                .padding(.vertical)
        }
        .padding(.horizontal)
        .background(.white)
    }
}

#Preview {
    BookDescriptionSection(title: "Descirption", subtitle: "Lorem ipsum")
}
