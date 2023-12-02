//
//  OnBoardingView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/26/23.
//

import SwiftUI

struct OnBoardingView: View {
  @State private var isAnimating = false
  @State private var animateGradient = false

  var body: some View {
    ZStack {
      VStack(spacing: 20) {
        Image("undraw_Bookshelves")
          .resizable()
          .scaledToFit()
          .scaleEffect(isAnimating ? 1.0 : 0.6)
        Text("Features")
          .foregroundColor(Color("TextColor"))
          .font(Font.custom("NewYork-Regular", size: 34))
          .fontWeight(.heavy)
        Text("""
          • Search for books
          • View book details
          • Add/rate books to 'Read' shelf
          • Add and remove Meetings
          """)
          .foregroundColor(Color("TextColor"))
          .multilineTextAlignment(.leading)
          .padding()
          .frame(maxWidth: 480)
          .font(Font.custom("NewYork-Regular", size: 20))
        StartButtonView()
      }
    }
    .onAppear {
      withAnimation(.easeOut(duration: 0.5)) {
        isAnimating = true
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    .background(
      LinearGradient(
        gradient: Gradient(
        colors: [Color("GradientLightColor"), Color("GradientDarkColor")]),
        startPoint: .top,
        endPoint: .bottom)
      .hueRotation(.degrees(animateGradient ? 45 : 0))
    )
    .cornerRadius(20)
    .padding(.horizontal, 20)
  }
}

struct OnBoardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnBoardingView()
  }
}
