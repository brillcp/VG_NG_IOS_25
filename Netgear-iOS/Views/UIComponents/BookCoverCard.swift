//
//  PageDetailView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookCoverCard<ViewModel: BookViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 24.0) {
            AsyncBookImage(viewModel: viewModel)
                .frame(width: 160.0, height: 240.0)
                .clipShape(RoundedRectangle.bookCornerRadius)

            Text(viewModel.volumeInfo.title)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
        }
        .padding(32.0)
        .foregroundStyle(.black)
    }
}

#Preview {
    BookCoverCard(viewModel: BookViewModel(book: .common))
}
