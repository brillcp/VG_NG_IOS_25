//
//  SearchState.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-08.
//

import Foundation

enum SearchState {
    case idle
    case searching
    case loaded([BookViewModel])
    case failed(String)

    var isLoading: Bool {
        if case .searching = self { return true }
        return false
    }

    var isError: Bool {
        if case .failed = self { return true }
        return false
    }

    var errorMessage: String? {
        if case .failed(let message) = self { return message }
        return nil
    }

    var books: [BookViewModel] {
        if case .loaded(let books) = self { return books }
        return []
    }

    var hasSearched: Bool {
        switch self {
        case .idle, .searching:
            return false
        case .loaded, .failed:
            return true
        }
    }
}
