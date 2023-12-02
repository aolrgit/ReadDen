//
//  MeetingsView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/25/23.
//

import SwiftUI

struct MeetingsView: View {
  @ObservedObject var meetingStore: MeetingStore

  var body: some View {
    NavigationStack {
      VStack {
        if !meetingStore.meetings.isEmpty {
          List(meetingStore.meetings.sorted { $0.meetingDate > $1.meetingDate }) { meeting in
            MeetingRow(meeting: meeting)
              .swipeActions {
                Button(role: .destructive) {
                  print("Deleting meeting")
                  meetingStore.deleteMeeting(delMeeting: meeting)
                } label: {
                  Label("Delete", systemImage: "trash.fill")
                }
              }
              .accessibilityIdentifier("meetingsList.meetingRow")
          }
          .background(Color("AmbientColor"))
          .scrollContentBackground(.hidden)
          .accessibilityIdentifier("meetingsList")
        } else {
          HStack {
            Text("No meetings scheduled yet!\nClick + above to add a meeting.")
              .font(Font.custom("NewYork-Regular", size: 20))
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color("AmbientColor"))
    }
    .navigationBarTitle("Meetings", displayMode: .inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        AddMeetingButton(meetingStore: meetingStore)
      }
    }
  }
}

struct MeetingRow: View {
  var meeting: Meeting
  var body: some View {
    VStack(alignment: .leading) {
      Text(meeting.meetingTitle)
        .font(Font.custom("NewYork-Regular", size: 22))
        .bold()
        .padding(.bottom)
        .accessibilityIdentifier(meeting.meetingTitle)
      Text(meeting.meetingDate.formatted(date: .abbreviated, time: .omitted) + " " + meeting.meetingTime)
        .font(Font.custom("NewYork-Regular", size: 20))
      Text("Guests: \(meeting.attendees)").font(Font.custom("NewYork-Regular", size: 20))
      Text("Book: " + meeting.meetingBook).font(Font.custom("NewYork-Regular", size: 20))
    }
    .listRowBackground(Color("AmbientColor"))
    .lineSpacing(10)
  }
}

struct MeetingsView_Previews: PreviewProvider {
  static var previews: some View {
    MeetingsView(meetingStore: MeetingStore())
  }
}
