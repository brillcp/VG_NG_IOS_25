//
//  Netgear_iOSTests.swift
//  Netgear-iOSTests
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Testing
import Networking
@testable import Netgear_iOS
import Foundation
import XCTest

struct Netgear_iOSTests {

    @Test
    func testSearchBooksReturnsViewModels() async throws {
        let mockBooks = [Book.common]
        let mockResponse = BookResponse(kind: "books#volumes", totalItems: 1000, items: mockBooks)
        let mockNetworkService = MockNetworkService()
        mockNetworkService.mockResponse = mockResponse

        let service = BookService()
        let results = try await service.searchBooks(query: "Swift")

        #expect(results.count == 10)
        await #expect(results.first?.id == "3uEEEQAAQBAJ")
    }

    @Test
    func testNetworkServiceHandlesDecodingError() async throws {
        let mockService = MockNetworkService()
        mockService.mockResponse = "Not a valid response"

        let service = BookService(networkService: mockService)
        await XCTAssertThrowsErrorAsync(try await service.searchBooks(query: "Swift"))
    }

    func XCTAssertThrowsErrorAsync<T>(
        _ expression: @autoclosure () async throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: ((Error) -> Void)? = nil
    ) async {
        do {
            _ = try await expression()
            XCTFail("Expected error to be thrown. " + message(), file: file, line: line)
        } catch {
            errorHandler?(error)
        }
    }
}

// MARK: - MockNetworkService
fileprivate final class MockNetworkService: NetworkServiceProtocol {
    var mockResponse: Decodable?

    func request<DataModel>(_ request: any Requestable, logResponse: Bool) async throws -> DataModel {
        guard let response = mockResponse as? DataModel else {
            throw NSError(
                domain: "MockNetworkService",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "No mock response set for type \(DataModel.self)"]
            )
        }
        return response
    }

    func data(_ request: any Requestable, logResponse: Bool) async throws -> Data {
        throw NSError(domain: "Unimplemented", code: -1)
    }

    func response(_ request: any Requestable, logResponse: Bool) async throws -> Networking.HTTP.StatusCode {
        throw NSError(domain: "Unimplemented", code: -1)
    }

    func downloader(url: URL) -> Network.Service.Downloader {
        fatalError("downloader(url:) not implemented")
    }
}
