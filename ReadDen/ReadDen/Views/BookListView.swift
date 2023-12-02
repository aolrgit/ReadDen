//
//  BookListView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/25/23.
//

import SwiftUI

struct BookListView: View {
  @ObservedObject var booksStore: BooksStore
  @ObservedObject var readBooksStore: ReadBooksStore
  @ObservedObject var meetingStore: MeetingStore
  @Binding var searchText: String
  @State var isSearchInitiated = false

  var body: some View {
    VStack {
      NavigationStack {
        TextField("Search for books..", text: $searchText)
          .onSubmit {
            print(searchText)
            isSearchInitiated = true
            Task {
              do {
                try await booksStore.findBooks(query: searchText)
              } catch {
                print(error.localizedDescription)
              }
            }
          }
          .textInputAutocapitalization(.never)
          .disableAutocorrection(true)
          .padding()
          .textFieldStyle(.roundedBorder)
          .font(Font.custom("NewYork-Regular", size: 17))
          .accessibilityIdentifier("searchText")
        if !booksStore.books.isEmpty {
          List(booksStore.books) { book in
            NavigationLink(
              destination: BookView(readBooksStore: readBooksStore, meetingStore: meetingStore, book: book)
            ) {
              BookListRowView(book: book)
                .accessibilityIdentifier("booksList.bookrow")
            }
            .listRowBackground(Color("AmbientColor"))
          }
          .listStyle(.grouped)
          .background(Color("AmbientColor"))
          .scrollContentBackground(.hidden)
          .accessibilityIdentifier("booksList")
          Spacer()
        } else {
          Spacer()
          HStack {
            Image(systemName: isSearchInitiated ? "magnifyingglass" : "exclamationmark.triangle")
            Text(isSearchInitiated ? "No books found for search criteria!" : "No books available!")
              .font(Font.custom("NewYork-Regular", size: 20))
          }
          Spacer()
        }
      }
      .navigationBarTitle("Find Books", displayMode: .inline)
      .font(Font.custom("NewYork-Regular", size: 20))
    }
    .background(Color("AmbientColor"))
  }
}

struct BookListView_Previews: PreviewProvider {
  static var previews: some View {
    BookListView(
      booksStore: BooksStore(),
      readBooksStore: ReadBooksStore(),
      meetingStore: MeetingStore(),
      searchText: .constant(""))
  }
}
