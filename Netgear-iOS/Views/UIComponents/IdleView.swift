//
//  IdleView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct IdleView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "book.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.indigo, .purple],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            Text("Find books and authors")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    IdleView()
}
