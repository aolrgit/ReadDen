//
//  ContentView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/24/23.
//

import SwiftUI

struct ContentView: View {
  @StateObject var booksStore: BooksStore
  @StateObject var meetingStore: MeetingStore
  @StateObject var readBooksStore: ReadBooksStore

  var body: some View {
    NavigationStack {
      ContentTabView(booksStore: booksStore, meetingStore: meetingStore, readBooksStore: readBooksStore)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(booksStore: BooksStore(), meetingStore: MeetingStore(), readBooksStore: ReadBooksStore())
  }
}
