//
//  URL.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation

extension URL {
    static var googleBookAPI: URL {
        URL(string: "https://www.googleapis.com/books/v1/")!
    }

    init?(string str: String?) {
        guard let str else { return nil }
        self.init(string: str)
    }
}
