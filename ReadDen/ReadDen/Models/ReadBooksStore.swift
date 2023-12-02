//
//  ReadBooksStore.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/26/23.
//

import Foundation

public extension FileManager {
  static var documentsDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}

class ReadBooksStore: ObservableObject {
  @Published var readBooks: [Book] = []
  @Published var errorMessage: String = ""
  var count: Int = 0
  init() {
    loadapiJSON()
  }

  private func saveReadBookstoJSON() {
    let newBooksList = BooksList(totalItems: count, items: readBooks)
    // print("Trying to save read books list with count \(newBooksList.items.count)")
    let encoder = JSONEncoder()
    let booksWriteJSON = URL(
      fileURLWithPath: "readBooksList",
      relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    do {
      // print("Saving to -> ")
      // print(booksWriteJSON)
      let newBooksData = try encoder.encode(newBooksList)
      try newBooksData.write(to: booksWriteJSON)
    } catch let error {
      print(error)
    }
  }

  func loadapiJSON() {
    let decoder = JSONDecoder()
    let booksBundleJSON: URL? = Bundle.main.url(forResource: "readBooksList", withExtension: "json")

    // Commented code to use a filename that does not exist
    // let booksBundleJSON: URL? = Bundle.main.url(forResource: "unreadBooksList", withExtension: "json")

    let booksDocJSON = booksBundleJSON ?? URL(
      fileURLWithPath: "readBooksList",
      relativeTo: FileManager.documentsDirectoryURL
    ).appendingPathExtension("json")

    if FileManager.default.fileExists(atPath: booksDocJSON.path()) {
      do {
        let booksData = try Data(contentsOf: booksDocJSON)
        let booksList = try decoder.decode(BooksList.self, from: booksData)
        readBooks = booksList.items
        count = readBooks.count
      } catch let error {
        print(error)
      }
    } else {
      errorMessage = "Books file not found"
      // print("JSON file not found")
    }
  }

  func addReadBooks(newBook: Book) -> Bool {
    var isBookRepeated = false
    if let index = readBooks.firstIndex(where: { $0.id == newBook.id }) {
      isBookRepeated = true
      print(index)
    } else {
      readBooks.append(newBook)
      count += 1
      saveReadBookstoJSON()
    }
    return isBookRepeated
  }

  func deleteBook(delBook: Book) {
    if let index = readBooks.firstIndex(where: { $0.id == delBook.id }) {
      readBooks.remove(at: index)
    }
  }

  func rateBook(ratedBook: Book, rating: Int) {
    if let index = readBooks.firstIndex(where: { $0.id == ratedBook.id }) {
      readBooks[index].volumeInfo.averageRating = Double(rating)
    }
  }
}
