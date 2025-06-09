//
//  BookModel.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation

struct BookResponse: Codable {
    let kind: String
    let totalItems: Int
    let items: [Book]
}

struct Book: Codable, Identifiable {
    let id: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo?
    let searchInfo: SearchInfo?
    let accessInfo: AccessInfo?
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let industryIdentifiers: [IndustryIdentifier]?
    let readingModes: ReadingModes?
    let pageCount: Int?
    let printType: String?
    let categories: [String]?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let panelizationSummary: PanelizationSummary?
    let imageLinks: ImageLinks?
    let language: String?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
}

struct IndustryIdentifier: Codable {
    let type: String
    let identifier: String
}

struct ReadingModes: Codable {
    let text: Bool
    let image: Bool
}

struct PanelizationSummary: Codable {
    let containsEpubBubbles: Bool
    let containsImageBubbles: Bool
}

struct ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
}

struct SaleInfo: Codable {
    let country: String
    let saleability: String
    let isEbook: Bool
    let listPrice: Price?
    let retailPrice: Price?
    let buyLink: String?
    let offers: [Offer]?
}

struct Price: Codable {
    let amount: Double?
    let amountInMicros: Int64?
    let currencyCode: String
}

struct Offer: Codable {
    let finskyOfferType: Int
    let listPrice: Price
    let retailPrice: Price
}

struct SearchInfo: Codable {
    let textSnippet: String
}

struct AccessInfo: Codable {
    let country: String
    let textToSpeechPermission: String
    let webReaderLink: String
}

extension VolumeInfo {
    var smallThumbnailURL: URL? {
        URL(string: imageLinks?.smallThumbnail)
    }

    var thumbnailURL: URL? {
        URL(string: imageLinks?.thumbnail)
    }

    static var common: VolumeInfo {
        .init(
            title: "title",
            subtitle: "subtitle",
            authors: ["author"],
            publisher: "publisher",
            publishedDate: "2025-01-01",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae sapien pellentesque habitant morbi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae sapien pellentesque habitant morbi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae sapien pellentesque habitant morbi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae sapien pellentesque habitant morbi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae sapien pellentesque habitant morbi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae sapien pellentesque habitant morbi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae sapien pellentesque habitant morbi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae sapien pellentesque habitant morbi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae sapien pellentesque habitant morbi.",
            industryIdentifiers: nil,
            readingModes: nil,
            pageCount: 314,
            printType: "Book",
            categories: ["comedy"],
            maturityRating: nil,
            allowAnonLogging: nil,
            contentVersion: nil,
            panelizationSummary: nil,
            imageLinks: .init(
                smallThumbnail: "http://books.google.com/books/content?id=3ikDEAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                thumbnail: "http://books.google.com/books/content?id=3ikDEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
            ),
            language: "eng",
            previewLink: nil,
            infoLink: nil,
            canonicalVolumeLink: nil
        )
    }
}

extension Book {
    static var common: Book {
        .init(
            id: "id",
            volumeInfo: .common,
            saleInfo: .init(
                country: "SE",
                saleability: "",
                isEbook: false,
                listPrice: nil,
                retailPrice: .init(amount: 149.99, amountInMicros: 0, currencyCode: "SEK"),
                buyLink: "https://google.com",
                offers: nil
            ),
            searchInfo: .init(
                textSnippet: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
            ),
            accessInfo: .init(
                country: "SE",
                textToSpeechPermission: "ALLOWED",
                webReaderLink: "https://google.com"
            )
        )
    }
}
