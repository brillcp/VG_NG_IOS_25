//
//  SearchView.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct SearchView<ViewModel: SearchViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(viewModel.books) { book in
                        VStack(alignment: .leading, spacing: 4) {
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Search Books")
            .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                Task { await viewModel.search() }
            }
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
