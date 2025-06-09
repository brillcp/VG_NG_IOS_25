//
//  String.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-09.
//

import Foundation

extension String {
    func truncated(limit: Int) -> String {
        count > limit ? prefix(limit) + "…" : self
    }
}
