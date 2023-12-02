//
//  BookView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/24/23.
//

import SwiftUI

struct BookView: View {
  @ObservedObject var readBooksStore: ReadBooksStore
  @ObservedObject var meetingStore: MeetingStore
  var book: Book
  @Environment(\.verticalSizeClass)
  var verticalSizeClass
  @Environment(\.horizontalSizeClass)
  var horizontalSizeClass
  var body: some View {
    VStack {
      if verticalSizeClass == .regular && horizontalSizeClass == .compact {
        VStack {
          BookImageView(book: book)
          BookDetailsView(book: book)
            .padding(.bottom)
          BookSynopsisView(book: book)
          AddBookButton(readBooksStore: readBooksStore, book: book)
            .accessibilityIdentifier("addBookButton")
        }
      } else {
        HStack {
          BookImageView(book: book)
          BookDetailsView(book: book)
          VStack {
            BookSynopsisView(book: book)
            AddBookButton(readBooksStore: readBooksStore, book: book)
              .accessibilityIdentifier("addBookButton")
          }
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color("AmbientColor"))
    .accessibilityIdentifier("BookViewLabel")
  }
}

struct BookImageView: View {
  var book: Book
  var body: some View {
    VStack {
      AsyncImage(
        url: URL(
          string: book.volumeInfo.imageLinks.thumbnail.replacingOccurrences(
            of: "http",
            with: "https"))
      ) { image in
        image.resizable()
          .frame(width: 200, height: 300)
          .border(Color("ImageBorderColor"))
      } placeholder: {
        ProgressView()
      }
    }
  }
}

struct BookSynopsisView: View {
  var book: Book
  var body: some View {
    Text(book.searchInfo?.textSnippet ?? "No synopsis available")
      .truncationMode(.middle)
      .padding()
      .font(Font.custom("NewYork-Regular", size: 17))
  }
}

struct AddBookButton: View {
  @ObservedObject var readBooksStore: ReadBooksStore
  @State private var scale = 1.0
  @State private var showingAlert = false

  var book: Book
  var body: some View {
    Button("Add to Books we've Read") {
      showingAlert = readBooksStore.addReadBooks(newBook: book)
    }
    .scaleEffect(scale)
    .animation(.easeInOut(duration: 0.5), value: scale)
    .padding(Constants.General.paddingOrWidth)
    .background(Color("AccentColor"))
    .overlay(
      RoundedRectangle(cornerRadius: Constants.General.buttonCornerRadius)
        .strokeBorder(Color("AmbientColor"), lineWidth: Constants.General.lineWidth)
    )
    .foregroundColor(.black)
    .cornerRadius(Constants.General.buttonCornerRadius)
    .alert("This book is already added.", isPresented: $showingAlert) {
      Button("OK", role: .cancel) { }
        .accessibilityIdentifier("bookRepeatedLabel")
    }
  }
}

struct BookView_Previews: PreviewProvider {
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
    BookView(readBooksStore: ReadBooksStore(), meetingStore: MeetingStore(), book: bookExample)
  }
}
