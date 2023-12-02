//
//  BooksList.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/24/23.
//

import Foundation

struct BooksList: Codable {
  let totalItems: Int
  let items: [Book]
}
struct Book: Codable, Identifiable {
  let kind, id, etag: String
  var volumeInfo: VolumeInfo
  let saleInfo: SaleInfo
  let searchInfo: SearchInfo?
}
struct SaleInfo: Codable {
  let retailPrice: SaleInfoListPrice?
}
struct SaleInfoListPrice: Codable {
  let amount: Double
  let currencyCode: String
}
struct SearchInfo: Codable {
  let textSnippet: String
}
struct VolumeInfo: Codable {
  let title: String
  let authors: [String]?
  let pageCount: Int?
  var averageRating: Double?
  let imageLinks: ImageLinks
}

struct ImageLinks: Codable {
  let smallThumbnail, thumbnail: String
}
