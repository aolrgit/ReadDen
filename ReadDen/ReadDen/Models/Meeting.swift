//
//  Meeting.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/25/23.
//

import Foundation

struct Meeting: Identifiable, Codable {
  var id = UUID()
  let meetingTitle: String
  let meetingDate: Date
  let meetingTime: String
  let meetingBook: String
  let attendees: Int
}
