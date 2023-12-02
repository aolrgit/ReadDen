//
//  ReadBookRatingView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/28/23.
//

import SwiftUI

struct ReadBookRatingView: View {
  @Binding var rating: Int
  var maximumRating = 5
  var offImage: Image?
  var onImage = Image(systemName: "star.fill")
  var offColor = Color.gray
  var onColor = Color.yellow

  func image(for number: Int) -> Image {
    var img = onImage
    if number > rating {
      img = offImage ?? onImage
    }
    return img
  }
  var body: some View {
    HStack {
      ForEach(1..<maximumRating + 1, id: \.self) { number in
        Button {
          rating = number
          print("chnaged rating to \(rating)")
        } label: {
          image(for: number)
            .foregroundStyle(number > rating ? offColor : onColor)
        }
      }
    }
    .buttonStyle(.plain)
  }
}
