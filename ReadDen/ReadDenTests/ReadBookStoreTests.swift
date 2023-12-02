//
//  ReadBookStoreTests.swift
//  ReadBookStoreTests
//
//  Created by Shashank Sharma on 11/24/23.
//

import XCTest
@testable import ReadDen

final class ReadBookStoreTests: XCTestCase {
  var bookExample = Book(
    kind: "",
    id: "WoNE62wPkBEC",
    etag: "qG1Mv+dc2YQ",
    volumeInfo:
      VolumeInfo(
        title: "Crooked House",
        authors: ["Agatha Christie"],
        pageCount: 256,
        averageRating: 5,
        imageLinks: ImageLinks(
          smallThumbnail: "http://books.google.com/books/content?id=WoNE62wPkBEC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api", thumbnail: "http://books.google.com/books/content?id=WoNE62wPkBEC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")),
    saleInfo: SaleInfo(
      retailPrice: SaleInfoListPrice(
        amount: 14.99,
        currencyCode: "USD")),
    searchInfo: SearchInfo(
      textSnippet: "In a career that spans over half a century, her name is synonymous with brilliant deception"))

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_ReadBookStore_AddBook_CheckCount() throws {
    let readBookStore = ReadBooksStore()
    let readBookCount = readBookStore.readBooks.count
    let bookAddFailed = readBookStore.addReadBooks(newBook: bookExample)
    let newReadBookCount = readBookStore.readBooks.count
    XCTAssertEqual(readBookCount + 1, newReadBookCount)
    XCTAssertFalse(bookAddFailed)
  }

  func test_ReadBookStore_AddBook_RepeatBook() throws {
    let readBookStore = ReadBooksStore()
    let bookAddFailed = readBookStore.addReadBooks(newBook: bookExample)
    let bookRepeatAddFailed = readBookStore.addReadBooks(newBook: bookExample)
    XCTAssertFalse(bookAddFailed)
    XCTAssertTrue(bookRepeatAddFailed)
  }

  func test_ReadBookStore_DeleteBook() throws {
    let readBookStore = ReadBooksStore()
    let bookAddFailed = readBookStore.addReadBooks(newBook: bookExample)
    let readBookCount = readBookStore.readBooks.count
    readBookStore.deleteBook(delBook: bookExample)
    let newReadBookCount = readBookStore.readBooks.count
    XCTAssertEqual(readBookCount - 1, newReadBookCount)
    XCTAssertFalse(bookAddFailed)
  }

  func test_ReadBookStore_RateBook() throws {
    var newRating = 0
    let readBookStore = ReadBooksStore()
    let bookAddFailed = readBookStore.addReadBooks(newBook: bookExample)
    readBookStore.rateBook(ratedBook: bookExample, rating: 3)
    if let index = readBookStore.readBooks.firstIndex(where: { $0.id == bookExample.id }) {
      if let dblRating = readBookStore.readBooks[index].volumeInfo.averageRating {
        newRating = Int(dblRating)
      }
    }
    XCTAssertEqual(newRating, 3)
    XCTAssertFalse(bookAddFailed)
  }
}
