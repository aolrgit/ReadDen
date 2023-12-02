//
//  ReadBooksListView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/26/23.
//

import SwiftUI

struct ReadBooksListView: View {
  @ObservedObject var readBooksStore: ReadBooksStore
  var body: some View {
    NavigationStack {
      VStack {
        if !readBooksStore.readBooks.isEmpty {
          List(readBooksStore.readBooks) { book in
            ReadBookView(readBooksStore: readBooksStore, readBook: book)
              .listRowBackground(Color("AmbientColor"))
              .swipeActions {
                Button(role: .destructive) {
                  print("Deleting book")
                  readBooksStore.deleteBook(delBook: book)
                } label: {
                  Label("Delete", systemImage: "trash.fill")
                }
              }
              .accessibilityIdentifier("readBooksList.book")
          }
          .background(Color("AmbientColor"))
          .scrollContentBackground(.hidden)
        } else {
          HStack {
            Text("No books added yet! Go to a book's details page to add it.")
              .font(Font.custom("NewYork-Regular", size: 20))
              .padding()
              .accessibilityIdentifier("emptyReadBooksLabel")
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color("AmbientColor"))
    }
    .navigationBarTitle("Books We've Read", displayMode: .inline)
  }
}

struct ReadBooksListView_Previews: PreviewProvider {
  static var previews: some View {
    ReadBooksListView(readBooksStore: ReadBooksStore())
  }
}
