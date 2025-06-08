//
//  BookDetailView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookDetailView: View {
    @State private var scrollOffset: CGFloat = 0.0
    @State private var lastProgress: CGFloat = 0.0

    let book: BookViewModel

    var body: some View {
        ZStack(alignment: .top) {
            backgroundColorView
            mainScrollView
            navigationBarOverlay
        }
    }
}

// MARK: - View Components
private extension BookDetailView {
    var backgroundColorView: some View {
        VStack(spacing: 0) {
            book.color
                .frame(height: 180)
            Spacer()
        }
        .ignoresSafeArea()
    }

    var mainScrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                scrollOffsetTracker
                BookCoverSection(book: book)
                bookContentSections
            }
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: handleScrollChange)
        .setupNavigationBar(with: book.color)
    }

    var scrollOffsetTracker: some View {
        GeometryReader { proxy in
            Color.clear
                .frame(height: 0)
                .preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: proxy.frame(in: .named("scroll")).minY
                )
        }
    }

    @ViewBuilder
    var bookContentSections: some View {
        if let description = book.volumeInfo.description {
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

        if let publisher = book.volumeInfo.publisher {
            BookDescriptionSection(
                title: "Publisher",
                image: "building.2",
                subtitle: publisher
            )
        }
    }

    var navigationBarOverlay: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .frame(height: navigationBarHeight)
            .opacity(currentFadeProgress)
            .ignoresSafeArea()
    }
}

// MARK: - Computed Properties
private extension BookDetailView {
    var navigationBarHeight: CGFloat {
        UIApplication.shared.statusBarHeight
    }

    var currentFadeProgress: CGFloat {
        fadeProgress(for: scrollOffset)
    }
}

// MARK: - Methods
private extension BookDetailView {
    func handleScrollChange(_ newValue: CGFloat) {
        let clampedValue = clampScrollOffset(newValue)
        let progress = fadeProgress(for: clampedValue)

        guard shouldUpdateProgress(progress) else { return }

        scrollOffset = clampedValue
        lastProgress = progress
    }

    func clampScrollOffset(_ value: CGFloat) -> CGFloat {
        max(min(value, 0), -navigationBarHeight)
    }

    func shouldUpdateProgress(_ progress: CGFloat) -> Bool {
        abs(progress - lastProgress) > 0.01
    }

    func fadeProgress(for offset: CGFloat) -> CGFloat {
        let fadeStart: CGFloat = 0
        let fadeEnd: CGFloat = -navigationBarHeight

        guard offset <= fadeStart else { return 0 }

        let progress = (offset - fadeStart) / (fadeEnd - fadeStart)
        return min(max(progress, 0), 1)
    }
}

// MARK: - View Modifiers
private extension View {
    func setupNavigationBar(with color: Color) -> some View {
        self
            .toolbarBackground(color, for: .navigationBar)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(color.isDark ? .dark : .light, for: .navigationBar)
    }
}

// MARK: - Preference Key
private extension BookDetailView {
    struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
    }
}

#Preview {
    BookDetailView(book: .init(book: .common))
}
