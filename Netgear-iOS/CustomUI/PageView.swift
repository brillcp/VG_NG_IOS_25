//
//  PageView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct PageView: View {
    @Namespace private var namespace

    let books: [BookViewModel]
    @Binding var selectedPage: Int
    
    var body: some View {
        VStack {
            TabView(selection: $selectedPage) {
                ForEach(Array(books.enumerated()), id: \.element.id) { index, book in
                    NavigationLink {
                        BookDetailView(book: book)
                            .navigationTransition(.zoom(sourceID: book.id, in: namespace))
                    } label: {
                        BookCoverCard(book: book)
                            .matchedTransitionSource(id: book.id, in: namespace)
                    }
                    .tag(index)
                }
            }

            pageControl
                .padding()
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
    }
}

// MARK: -
private extension PageView {
    var pageControl: some View {
        HStack(spacing: 8) {
            ForEach(0..<books.count, id: \.self) { index in
                Circle()
                    .fill(index == selectedPage ? Color.primary : Color.secondary.opacity(0.4))
                    .frame(width: 8, height: 8)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: selectedPage)
    }
}

#Preview {
    PageView(books: [
        .init(book: .init(id: "id", volumeInfo: .common)),
        .init(book: .init(id: "id2", volumeInfo: .common))
    ], selectedPage: .constant(0))
}
