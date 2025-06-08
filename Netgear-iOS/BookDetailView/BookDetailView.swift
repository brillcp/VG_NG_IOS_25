//
//  BookDetailView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI
import SwiftUIX

struct BookDetailView: View {
    @State private var scrollOffset: CGFloat = 0.0

    let book: BookViewModel

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                book.color
                    .frame(height: 180.0)
                Spacer()
            }
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    GeometryReader {
                        Color.clear
                            .preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: $0.frame(in: .named("scroll")).origin.y
                            )
                    }
                    BookCoverSection(book: book)

                    if let description = volumeInfo.description {
                        BookDescriptionSection(
                            title: "Description",
                            subtitle: description
                        )
                        .padding(.top)
                    }

                    if let snippet = book.searchInfo?.textSnippet {
                        BookDescriptionSection(
                            title: "Snippet",
                            subtitle: snippet
                        )
                    }

                    if let publisher = volumeInfo.publisher {
                        BookDescriptionSection(
                            title: "Publisher",
                            subtitle: publisher
                        )
                    }
                }
            }
            .toolbarBackground(book.color, for: .navigationBar)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(book.color.isDark ? .dark : .light, for: .navigationBar)
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) {
                scrollOffset = $0
            }

            VStack {
                BlurEffectView(style: .regular)
                    .frame(height: 86.0)
                Spacer()
            }
            .ignoresSafeArea()
            .opacity(1.0 - opacity())
            .animation(.easeInOut, value: scrollOffset)
        }
        .tint(.red)
    }
}

// MARK: -
private extension BookDetailView {
    var volumeInfo: VolumeInfo {
        book.volumeInfo
    }

    struct ScrollOffsetPreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGFloat { .zero }
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
    }

    func opacity() -> CGFloat {
        let threshold: CGFloat = 4
        let progress = min(max(-scrollOffset / threshold, 0), 1)
        print(progress)
        return 1.0 - progress
    }
}

#Preview {
    BookDetailView(book: .init(book: .common))
}
