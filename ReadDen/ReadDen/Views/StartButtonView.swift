//
//  StartButtonView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/26/23.
//

import SwiftUI

struct StartButtonView: View {
  @AppStorage("isOnboarding")
  var isOnboarding: Bool?
  var body: some View {
    Button(action: {
      isOnboarding = false
    }, label: {
      HStack(spacing: 8) {
        Text("Start")
          .font(Font.custom("NewYork-Regular", size: 20))
          .bold()
        Image(systemName: "arrow.right.circle")
          .imageScale(.large)
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
      .background(
        Capsule().strokeBorder(Color("TextColor"), lineWidth: 1.25)
      )
    }
    )
    .accentColor(Color("TextColor"))
  }
}

struct StartButtonView_Previews: PreviewProvider {
  static var previews: some View {
    StartButtonView()
  }
}
