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
    @State private var lastProgress: CGFloat = 0.0

    let book: BookViewModel

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                book.color
                    .frame(height: 180)
                Spacer()
            }
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Spacer to measure scroll offset
                    GeometryReader { proxy in
                        Color.clear
                            .frame(height: 0)
                            .preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: proxy.frame(in: .named("scroll")).minY
                            )
                    }

                    BookCoverSection(book: book)

                    if let description = volumeInfo.description {
                        BookDescriptionSection(
                            title: "Description",
                            image: "quote.bubble",
                            subtitle: description
                        )
                        .padding(.top)
                    }

                    if let snippet = book.searchInfo?.textSnippet {
                        BookDescriptionSection(
                            title: "Snippet",
                            image: "text.quote",
                            subtitle: snippet
                        )
                    }

                    if let publisher = volumeInfo.publisher {
                        BookDescriptionSection(
                            title: "Publisher",
                            image: "building.2",
                            subtitle: publisher
                        )
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: setValue)
            .toolbarBackground(book.color, for: .navigationBar)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(book.color.isDark ? .dark : .light, for: .navigationBar)

            Rectangle()
                .fill(.ultraThinMaterial)
                .frame(height: navBarHeight)
                .opacity(fadeProgress(for: scrollOffset))
                .ignoresSafeArea()
        }
    }
}

// MARK: -
private extension BookDetailView {
    var volumeInfo: VolumeInfo {
        book.volumeInfo
    }

    var navBarHeight: CGFloat {
        UIApplication.shared.statusBarHeight
    }

    struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat { .zero }
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
    }

    func setValue(_ newValue: ScrollOffsetPreferenceKey.Value) {
        let clamped = max(min(newValue, 0), -navBarHeight)
        let progress = fadeProgress(for: clamped)

        if abs(progress - lastProgress) > 0.01 {
            scrollOffset = clamped
            lastProgress = progress
        }
    }

    func fadeProgress(for offset: CGFloat) -> CGFloat {
        let fadeStart: CGFloat = 0
        let fadeEnd: CGFloat = -navBarHeight

        guard offset <= fadeStart else { return 0 }

        let progress = (offset - fadeStart) / (fadeEnd - fadeStart)
        return min(max(progress, 0), 1)
    }
}

#Preview {
    BookDetailView(book: .init(book: .common))
}
