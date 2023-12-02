//
//  AsynchronousTestCaseBooks.swift
//  ReadDenTests
//
//  Created by Shashank Sharma on 11/29/23.
//

import XCTest
@testable import ReadDen

final class AsynchronousTestCaseBooks: XCTestCase {
  let timeout: TimeInterval = 2
  private var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "Books-Info", ofType: "plist") else {
      fatalError("Couldn't find file 'Books-Info.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'Books-Info.plist'.")
    }
    return value
  }
  // swiftlint:disable:next implicitly_unwrapped_optional
  var expectation: XCTestExpectation!
  override func setUp() {
    expectation = expectation(description: "Server responds in reasonable time")
  }

  func test_noServerResponse() {
    // swiftlint:disable:next force_unwrapping
    let url = URL(string: "googlebooksapi")!
    URLSession.shared.dataTask(with: url) { data, response, error in
      defer { self.expectation.fulfill() }

      XCTAssertNil(data)
      XCTAssertNil(response)
      XCTAssertNotNil(error)
    }
    .resume()
    waitForExpectations(timeout: timeout)
  }

  func test_decodeBooks() {
    // swiftlint:disable:next force_unwrapping
    var url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=inauthor:agatha%20christie&maxResults=15&filter=paid-ebooks")!
    url.append(queryItems: [URLQueryItem(name: "key", value: apiKey)])

    URLSession.shared.dataTask(with: url) { data, response, error in
      defer { self.expectation.fulfill() }
      XCTAssertNil(error)
      do {
        let response = try XCTUnwrap(response as? HTTPURLResponse)
        XCTAssertEqual(response.statusCode, 200)
        print(response.statusCode)
        let data = try XCTUnwrap(data)
        XCTAssertNoThrow(
          try JSONDecoder().decode(BooksList.self, from: data)
        )
      } catch { }
    }
    .resume()
    waitForExpectations(timeout: timeout)
  }

  func test_404() {
    // swiftlint:disable:next force_unwrapping
    var url = URL(string: "https://www.googleapis.com/audiobooks/v1/volumes?q=inauthor:agatha%20christie&maxResults=15&filter=paid-ebooks")!
    url.append(queryItems: [URLQueryItem(name: "key", value: apiKey)])
    URLSession.shared.dataTask(with: url) { data, response, error in
      defer { self.expectation.fulfill() }

      XCTAssertNil(error)
      do {
        let response = try XCTUnwrap(response as? HTTPURLResponse)
        XCTAssertEqual(response.statusCode, 404)

        let data = try XCTUnwrap(data)
        XCTAssertThrowsError(
          try JSONDecoder().decode(BooksList.self, from: data)
        ) { error in
          guard case DecodingError.dataCorrupted = error else {
            XCTFail("\(error)")
            return
          }
        }
      } catch { }
    }
    .resume()

    waitForExpectations(timeout: timeout)
  }
}
