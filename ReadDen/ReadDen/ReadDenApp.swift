//
//  ReadDenApp.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/24/23.
//

import SwiftUI

@main
struct ReadDenApp: App {
  @AppStorage("isOnboarding")
  var isOnboarding = true
  var body: some Scene {
    WindowGroup {
      if isOnboarding {
        OnBoardingView()
          .environment(\.font, Font.custom("NewYork-Regular", size: 17))
      } else {
        ContentView(booksStore: BooksStore(), meetingStore: MeetingStore(), readBooksStore: ReadBooksStore())
          .environment(\.font, Font.custom("NewYork-Regular", size: 17))
      }
    }
  }
}
