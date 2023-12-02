//
//  AddMeetingButton.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/28/23.
//

import SwiftUI

struct AddMeetingButton: View {
  @ObservedObject var meetingStore: MeetingStore
  @State private var scale = 1.0
  var body: some View {
    Button(action: {
      meetingStore.addingMeeting.toggle()
    }, label: {
      HStack {
        Image(systemName: "plus.circle")
          .font(Font.custom("NewYork-Regular", size: 20))
          .bold()
      }
      .padding(.bottom)
    }
    )
    .scaleEffect(scale)
    .animation(.easeInOut(duration: 0.5), value: scale)
    .sheet(isPresented: $meetingStore.addingMeeting) {
      AddNewMeeting(meetingStore: meetingStore)
    }
  }
}
