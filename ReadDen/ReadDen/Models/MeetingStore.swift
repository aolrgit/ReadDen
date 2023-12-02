//
//  MeetingStore.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/25/23.
//

import Foundation

class MeetingStore: ObservableObject {
  @Published var meetings: [Meeting] = []
  @Published var polledBooks: [Book] = []
  @Published var addingMeeting = false
  let formatter = DateFormatter()

  init() {
    formatter.dateFormat = "yyyy/MM/dd"
    meetings.append(Meeting(
      meetingTitle: "October Meeting",
      // swiftlint:disable:next force_unwrapping
      meetingDate: formatter.date(from: "2023/10/22")!,
      meetingTime: "11:30 AM CT",
      meetingBook: "Mexican Gothic",
      attendees: 7))
    meetings.append(Meeting(
      meetingTitle: "November Meeting",
      // swiftlint:disable:next force_unwrapping
      meetingDate: formatter.date(from: "2023/11/19")!,
      meetingTime: "11:30 AM CT",
      meetingBook: "The Bright Ages",
      attendees: 4))
  }

  func addMeeting(newMeeting: Meeting) -> Bool {
    var isMeetingRepeated = false
    print(newMeeting.meetingDate)
    if let index = meetings.firstIndex(
      where: { Calendar.current.isDate(
        $0.meetingDate,
        equalTo: newMeeting.meetingDate,
        toGranularity: .day)
      }
    ) {
      isMeetingRepeated = true
      print(index)
    } else {
      meetings.append(newMeeting)
    }
    return isMeetingRepeated
  }

  func deleteMeeting(delMeeting: Meeting) {
    if let index = meetings.firstIndex(where: { $0.id == delMeeting.id }) {
      meetings.remove(at: index)
    }
  }
}
