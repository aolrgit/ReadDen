//
//  BookDetailsView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/28/23.
//

import SwiftUI

struct BookDetailsView: View {
  var book: Book
  var authors: String {
    guard let authorVal = book.volumeInfo.authors else {
      return "Unknown"
    }
    return authorVal.compactMap { $0 }.joined(separator: ", ")
  }
  var rating: String {
    guard let ratingVal = book.volumeInfo.averageRating else {
      return "-"
    }
    return String(format: "%.1f", ratingVal)
  }

  var pageCount: String {
    guard let pgVal = book.volumeInfo.pageCount else {
      return "-"
    }
    return String(pgVal)
  }

  var retailPrice: String {
    guard let priceVal = book.saleInfo.retailPrice else {
      return "-"
    }
    return "$" + String(format: "%.2f", priceVal.amount)
  }
  var body: some View {
    VStack {
      Text(book.volumeInfo.title)
        .font(Font.custom("NewYork-Regular", size: 20))
        .bold()
      Text("Author(s): " + authors)
        .padding(.bottom)
        .font(Font.custom("NewYork-Regular", size: 17))
      HStack {
        VStack {
          Text("Pages")
            .font(Font.custom("NewYork-Regular", size: 17))
          Text(pageCount)
            .font(Font.custom("NewYork-Regular", size: 17))
        }
        VStack(alignment: .center) {
          Text("Rating")
            .font(Font.custom("NewYork-Regular", size: 17))
          HStack {
            Image(systemName: "star.fill").foregroundColor(Color("RatingColor"))
            Text(rating)
              .font(Font.custom("NewYork-Regular", size: 17))
          }
        }
        VStack {
          Text("Price")
            .font(Font.custom("NewYork-Regular", size: 17))
          Text(retailPrice)
            .font(Font.custom("NewYork-Regular", size: 17))
        }
      }
    }
  }
}
