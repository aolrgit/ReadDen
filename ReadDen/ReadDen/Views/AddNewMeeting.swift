//
//  AddNewMeeting.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/25/23.
//

import SwiftUI

struct AddNewMeeting: View {
  @Environment(\.dismiss)
  var dismiss
  @ObservedObject var meetingStore: MeetingStore
  @State private var meetingTitle = ""
  @State private var meetingDate = Date()
  @State private var bookTitle = ""
  @State private var attendees = 1
  @State private var category = "No Category"
  @State private var scale = 1.0
  @State private var isMeetingRepeated = false

  var body: some View {
    NavigationStack {
      VStack {
        Form {
          Section(header: Text("Meeting Title").font(Font.custom("NewYork-Regular", size: 13))) {
            TextField("Title", text: $meetingTitle)
              .disableAutocorrection(true)
              .accessibilityIdentifier("meetingTitleLabel")
              .font(Font.custom("NewYork-Regular", size: 17))
          }
          Section(header: Text("Date").font(Font.custom("NewYork-Regular", size: 13))) {
            DatePicker("Meet on", selection: $meetingDate, in: PartialRangeFrom(Date.now), displayedComponents: [.date])
              .font(Font.custom("NewYork-Regular", size: 17))
          }
          Section(header: Text("Book").font(Font.custom("NewYork-Regular", size: 13))) {
            TextField("Title", text: $bookTitle)
              .disableAutocorrection(true)
              .accessibilityIdentifier("bookTitleLabel")
              .font(Font.custom("NewYork-Regular", size: 17))
          }
          Section(header: Text("Attendees").font(Font.custom("NewYork-Regular", size: 13))) {
            Stepper(value: $attendees, in: 1...20, step: 1) {
              Text("Guests: \(attendees)")
                .font(Font.custom("NewYork-Regular", size: 17))
            }
          }
        }
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
              dismiss()
            }, label: {
              Text("Cancel")
                .font(Font.custom("NewYork-Regular", size: 17))
                .accessibilityIdentifier("cancelNewMeetingButton")
            })
          }
          ToolbarItem(placement: .principal) {
            Text("Adding New Meeting")
              .font(Font.custom("NewYork-Regular", size: 17))
              .bold()
              .accessibilityIdentifier("newMeetingSheet")
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
              isMeetingRepeated = meetingStore.addMeeting(
                newMeeting: Meeting(
                  meetingTitle: meetingTitle,
                  meetingDate: meetingDate,
                  meetingTime: "11:30 AM CT",
                  meetingBook: bookTitle,
                  attendees: attendees))
              if !isMeetingRepeated {
                dismiss()
              }
            }, label: {
              Text("Add")
                .font(Font.custom("NewYork-Regular", size: 17))
                .accessibilityIdentifier("addNewMeetingButton")
            })
            .disabled(meetingTitle.isEmpty || bookTitle.isEmpty)
            .scaleEffect(scale)
            .animation(.easeInOut(duration: 0.5), value: scale)
            .alert("A meeting already exists for this date.", isPresented: $isMeetingRepeated) {
              Button("OK", role: .cancel) { }
            }
          }
        }
        .scrollContentBackground(.hidden)
      }
      .background(Color("AmbientColor"))
    }
    .navigationTitle("AddNewMeetingBar")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct AddNewMeeting_Previews: PreviewProvider {
  static var previews: some View {
    AddNewMeeting(meetingStore: MeetingStore())
  }
}
