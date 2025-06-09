//
//  BookDetailView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookDetailView<ViewModel: BookViewModelProtocol>: View {
    @State private var shouldShowDescription: Bool = false
    @State private var scrollOffset: CGFloat = 0.0
    @State private var lastProgress: CGFloat = 0.0

    let viewModel: ViewModel

    var body: some View {
        ZStack(alignment: .top) {
            mainScrollView
            navigationBarOverlay
        }
        .onAppear(perform: viewModel.hapticFeedback)
    }
}

// MARK: - View Components
private extension BookDetailView {
    var mainScrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                BookCoverSection(viewModel: viewModel)
                bookContentSections
            }
            .background(scrollOffsetTracker)
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollOffsetKey.self, perform: handleScrollChange)
        .setupNavigationBar(with: viewModel.color)
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $shouldShowDescription) {
            BookDescriptionView(description: viewModel.volumeInfo.description ?? "")
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    var scrollOffsetTracker: some View {
        GeometryReader {
            Color.clear
                .preference(
                    key: ScrollOffsetKey.self,
                    value: $0.frame(in: .named("scroll")).minY
                )
        }
    }

    @ViewBuilder
    var bookContentSections: some View {
        if let description = viewModel.volumeInfo.description {
            Button {
                guard viewModel.shouldShowDescription else { return }
                shouldShowDescription.toggle()
            } label: {
                BookDescriptionSection(
                    title: "Description",
                    image: "quote.bubble",
                    subtitle: viewModel.descriptionTitle
                )
                .padding(.top)
            }
            .foregroundStyle(.black)
        }

        if let snippet = viewModel.searchInfo?.textSnippet {
            BookDescriptionSection(
                title: "Snippet",
                image: "text.quote",
                subtitle: snippet
            )
        }

        if let publisher = viewModel.volumeInfo.publisher {
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
            .opacity(shouldShowNavBarOverlay ? 1 : 0)
            .animation(.default, value: shouldShowNavBarOverlay)
            .ignoresSafeArea()
    }
}

// MARK: - Computed Properties
private extension BookDetailView {
    var navigationBarHeight: CGFloat {
        UIApplication.shared.statusBarHeight
    }

    var shouldShowNavBarOverlay: Bool {
        scrollOffset <= -navigationBarHeight * 0.2
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

    func fadeProgress(for offset: CGFloat) -> CGFloat {
        let fadeStart: CGFloat = 0
        let fadeEnd: CGFloat = -navigationBarHeight

        guard offset <= fadeStart else { return 0 }

        let progress = (offset - fadeStart) / (fadeEnd - fadeStart)
        return min(max(progress, 0), 1)
    }

    func shouldUpdateProgress(_ progress: CGFloat) -> Bool {
        abs(progress - lastProgress) > 0.01
    }
}

// MARK: - View Modifiers
private extension View {
    func setupNavigationBar(with color: Color) -> some View {
        self
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(color.isDark ? .dark : .light, for: .navigationBar)
    }
}

// MARK: - Preference Key
private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

#Preview {
    BookDetailView(viewModel: BookViewModel(book: .common))
}
