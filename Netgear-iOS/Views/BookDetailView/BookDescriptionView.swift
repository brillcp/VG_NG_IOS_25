//
//  BookDescriptionView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-09.
//

import SwiftUI

struct BookDescriptionView: View {
    private let hapticGenerator: UIImpactFeedbackGenerator

    let description: String
    
    var body: some View {
        ScrollView {
            VStack {
                Text(description)
                    .italic()
            }
            .frame(alignment: .top)
            .padding()
            .padding(.top)
        }
        .onAppear {
            hapticGenerator.impactOccurred()
        }
    }
}

#Preview {
    BookDescriptionView(description: Book.common.volumeInfo.description ?? "")
}
