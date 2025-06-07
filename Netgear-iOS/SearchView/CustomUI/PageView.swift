//
//  PageView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct PageView: View {
    let books: [Book]
    @Binding var selectedPage: Int

    var body: some View {
        TabView(selection: $selectedPage) {
            ForEach(Array(books.enumerated()), id: \.element.id) { index, book in
                NavigationLink {
                    Text(book.volumeInfo.description ?? "")
                        .padding()
                } label: {
                    Text(book.volumeInfo.title ?? "")
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
    }
}

#Preview {
    PageView(books: [], selectedPage: .constant(0))
}
