//
//  MeetingStoreTests.swift
//  ReadDenTests
//
//  Created by Shashank Sharma on 11/29/23.
//

import XCTest
@testable import ReadDen

final class MeetingStoreTests: XCTestCase {
  let meeting = Meeting(
    meetingTitle: "April Meeting",
    meetingDate: Date.now,
    meetingTime: "11:30 AM CT",
    meetingBook: "Forget the Alamo",
    attendees: 7)

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_MeetingStore_AddMeeting() throws {
    let meetingStore = MeetingStore()
    let meetingCount = meetingStore.meetings.count
    let isMeetingRepeated = meetingStore.addMeeting(newMeeting: meeting)
    let newMeetingCount = meetingStore.meetings.count
    XCTAssertEqual(meetingCount + 1, newMeetingCount)
  }

  func test_MeetingStore_DeleteMeeting_DoesNotExist() throws {
    let meetingStore = MeetingStore()
    let meetingCount = meetingStore.meetings.count
    meetingStore.deleteMeeting(delMeeting: meeting)
    let newMeetingCount = meetingStore.meetings.count
    XCTAssertEqual(meetingCount, newMeetingCount)
  }
}
