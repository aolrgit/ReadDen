//
//  BookStoreAPITests.swift
//  ReadDenTests
//
//  Created by Shashank Sharma on 11/29/23.
//

import XCTest
@testable import ReadDen

final class BookStoreAPITests: XCTestCase {
  @MainActor
  func test_getBooks() async {
    let bookStore = BooksStore()
    do {
      try await bookStore.findBooks(query: "Hobbit")
      XCTAssertTrue(!bookStore.books.isEmpty)
    } catch {
      print(error)
    }
  }

  @MainActor
  func test_getBooksURL() async {
    let bookStore = BooksStore()
    do {
      let request = try bookStore.getBooksRequest(query: "Hobbit")
      let (_, response) = try await URLSession.shared.data(for: request)
      if let httpResponse = response as? HTTPURLResponse {
        XCTAssertTrue((200..<300).contains(httpResponse.statusCode))
      }
    } catch {
      print(error)
    }
  }
}
