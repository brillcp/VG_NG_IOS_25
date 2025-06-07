//
//  GoogleBookAPI.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation
import Networking

enum GoogleBookAPI {
    case search(query: String)
}

// MARK: - Requestable
extension GoogleBookAPI: Requestable {
    var encoding: Request.Encoding { .query }
    var httpMethod: HTTP.Method { .get }

    var endpoint: EndpointType {
        switch self {
        case .search:
            APIEndpoint.search
        }
    }

    var parameters: HTTP.Parameters {
        switch self {
        case .search(let q):
            ["q": q]
        }
    }
}
