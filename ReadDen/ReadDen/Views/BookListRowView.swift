//
//  BookListRowView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/28/23.
//

import SwiftUI


struct BookListRowView: View {
  var book: Book
  var authors: String {
    guard let authorVal = book.volumeInfo.authors else {
      return "Unknown"
    }
    return authorVal.compactMap { $0 }.joined(separator: ", ")
  }
  var body: some View {
    HStack {
      AsyncImage(
        url: URL(
          string: book.volumeInfo.imageLinks.smallThumbnail.replacingOccurrences(
            of: "http",
            with: "https"))
      ) { image in
        image.resizable()
          .frame(width: 100, height: 150)
          .border(Color("ImageBorderColor"))
      } placeholder: {
        ProgressView()
      }
      VStack(alignment: .leading) {
        Text(book.volumeInfo.title)
          .font(Font.custom("NewYork-Regular", size: 20))
          .bold()
          .padding(.bottom)
        Text(authors)
          .font(Font.custom("NewYork-RegularItalic", size: 17))
      }
    }
  }
}
