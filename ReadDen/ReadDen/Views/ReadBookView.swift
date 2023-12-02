//
//  ReadBookView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/26/23.
//

import SwiftUI

struct ReadBookView: View {
  @ObservedObject var readBooksStore: ReadBooksStore
  var readBook: Book
  @State var bookRating: Int = 0

  var body: some View {
    HStack {
      AsyncImage(
        url: URL(
          string: readBook.volumeInfo.imageLinks.smallThumbnail.replacingOccurrences(
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
        Text(readBook.volumeInfo.title)
          .padding(.bottom)
          .font(Font.custom("NewYork-Regular", size: 20))
          .bold()
        Text("Rate this book")
          .font(Font.custom("NewYork-Regular", size: 17))
        ReadBookRatingView(rating: $bookRating)
      }
    }
    .onChange(of: bookRating) { _ in
      readBooksStore.rateBook(ratedBook: readBook, rating: bookRating)
    }
    .background(Color("AmbientColor"))
  }
}

struct ReadBookView_Previews: PreviewProvider {
  static var previews: some View {
    @State var bookExample = Book(
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
    ReadBookView(readBooksStore: ReadBooksStore(), readBook: bookExample)
  }
}
