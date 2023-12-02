//
//  BooksStore.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/24/23.
//

import Foundation
import SwiftUI

@MainActor
class BooksStore: ObservableObject {
  @Published var books: [Book] = []
  @Published var isImageResponseDownloaded = false

  enum BookDownloadError: Error {
    case urlError
    case failedToDownloadImage
    case invalidResponse
  }

  private var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "Books-Info", ofType: "plist") else {
      print("Couldn't find file 'Books-Info.plist'.")
      return ""
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      print("Couldn't find key 'API_KEY' in 'Books-Info.plist'.")
      return ""
    }
    return value
  }

  init() {
    Task {
      try await findBooks(query: "Barbara Kingsolver")
    }
  }

  func getBooksRequest(query: String) throws -> URLRequest {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "www.googleapis.com"
    urlComponents.path = "/books/v1/volumes"
    // swiftlint:disable:next line_length
    urlComponents.queryItems = [URLQueryItem(name: "q", value: query), URLQueryItem(name: "maxResults", value: "15"), URLQueryItem(name: "key", value: apiKey), URLQueryItem(name: "filter", value: "paid-ebooks")]

    guard let url = urlComponents.url else {
      throw BookDownloadError.urlError
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    return request
  }

  func findBooks(query: String) async throws {
    let request = try getBooksRequest(query: query)
    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      guard
        let httpResponse = response as? HTTPURLResponse,
        (200..<300).contains(httpResponse.statusCode)
      else {
        throw BookDownloadError.invalidResponse
      }
      print(httpResponse.statusCode)
      let booksData = try JSONDecoder().decode(BooksList.self, from: data)
      print("Books downloaded \(booksData.totalItems)")
      books = booksData.items
    } catch let error {
      print(error)
      throw BookDownloadError.failedToDownloadImage
    }
  }
}
