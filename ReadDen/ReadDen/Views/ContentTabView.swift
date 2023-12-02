//
//  ContentTabView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/28/23.
//

import SwiftUI

struct ContentTabView: View {
  @ObservedObject var booksStore: BooksStore
  @ObservedObject var meetingStore: MeetingStore
  @ObservedObject var readBooksStore: ReadBooksStore
  @State var searchText: String = ""
  @State var isDarkModeOn = UserDefaults.standard.object(forKey: "isDarkModeOn") as? Bool ?? false

  var body: some View {
    VStack {
      TabView {
        NavigationView {
          BookListView(
            booksStore: booksStore,
            readBooksStore: readBooksStore,
            meetingStore: meetingStore,
            searchText: $searchText)
        }
        .tabItem {
          Image(systemName: "magnifyingglass.circle")
            .resizable()
          Text("Find")
            .font(.custom("NewYork-Regular", size: 17))
        }
        NavigationView {
          ReadBooksListView(readBooksStore: readBooksStore)
        }
        .tabItem {
          Image(systemName: "tray")
            .resizable()
          Text("Read Books")
            .font(.custom("NewYork-Regular", size: 17))
        }
        NavigationView {
          MeetingsView(meetingStore: meetingStore)
        }
        .tabItem {
          Image(systemName: "list.bullet.clipboard")
            .resizable()
          Text("Meetings")
            .font(.custom("NewYork-Regular", size: 17))
            .tint(Color.orange)
        }

        NavigationView {
          SettingsView(isDarkModeOn: $isDarkModeOn)
        }
        .tabItem {
          Image(systemName: "gear")
            .resizable()
          Text("Settings")
            .font(.custom("NewYork-Regular", size: 17))
        }
      }
    }
    .preferredColorScheme(isDarkModeOn ? .dark : .light)
  }
}
