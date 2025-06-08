//
//  IdleView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct IdleView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.circle")
                .font(.system(size: 64))
                .fontWeight(.thin)
            Text("Find books and authors")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.secondary)
    }
}

#Preview {
    IdleView()
}
