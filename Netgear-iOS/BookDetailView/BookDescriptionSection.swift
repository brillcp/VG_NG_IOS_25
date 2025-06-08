//
//  BookDescriptionSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookDescriptionSection: View {
    let title: String
    let image: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: image)
                .bold()

            Text(subtitle)
                .font(.callout.italic())
                .multilineTextAlignment(.leading)
                .foregroundStyle(.secondary)

            Divider()
                .padding(.vertical)
        }
        .padding(.horizontal)
        .background(.white)
    }
}

#Preview {
    BookDescriptionSection(
        title: "Descirption",
        image: "person.fill",
        subtitle: "Lorem ipsum"
    )
}
