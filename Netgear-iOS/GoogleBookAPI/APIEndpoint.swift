//
//  APIEndpoint.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Networking

enum APIEndpoint {
    case search
}

// MARK: - EndpointType
extension APIEndpoint: EndpointType {
    var path: String {
        switch self {
        case .search:
            "volumes"
        }
    }
}
