//
//  BookDescriptionView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-09.
//

import SwiftUI

struct BookDescriptionView: View {
    let description: String
    
    var body: some View {
        ScrollView {
            VStack {
                Text(description)
            }
            .frame(alignment: .top)
            .padding()
            .padding(.top)
        }
    }
}

#Preview {
    BookDescriptionView(description: Book.common.volumeInfo.description ?? "")
}
