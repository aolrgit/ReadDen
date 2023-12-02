//
//  ReadDenUITests.swift
//  ReadDenUITests/Users/shashanksharma/Developer/kodeco-tutorials/ReadDen/ReadDen
//
//  Created by Shashank Sharma on 11/24/23.
//

import XCTest

final class ReadDenUITests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var app: XCUIApplication!
  var isDarkModeOn = UserDefaults.standard.object(forKey: "isDarkModeOn") as? Bool ?? false

  override func setUpWithError() throws {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_TabView_optionsExist() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Find"].tap()
    tabBar.buttons["Meetings"].tap()
    var tabLabel = app.staticTexts["Meetings"]
    XCTAssert(tabLabel.exists)
    tabBar.buttons["Settings"].tap()
    tabLabel = app.staticTexts["Settings"]
    XCTAssert(tabLabel.exists)
  }

  func test_BookView_emptyLabelExists() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Read Books"].tap()
    let tabLabel = app.staticTexts["emptyReadBooksLabel"]
    XCTAssert(tabLabel.exists)
  }

  func test_MeetingsView_RowExists() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Find"].tap()
    tabBar.buttons["Meetings"].tap()
    let tabLabel = app.staticTexts["meetingsList.meetingRow"]
    XCTAssert(tabLabel.exists)
  }

  func test_MeetingsView_sheetExists_onAdd() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Meetings"].tap()
    app.navigationBars["Meetings"].buttons["Add"].tap()
    let tabLabel = app.staticTexts["newMeetingSheet"]
    XCTAssert(tabLabel.exists)
  }

  func test_MeetingsView_sheetDoesNotExist() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Meetings"].tap()
    app.navigationBars["Meetings"].buttons["Add"].tap()
    app.buttons["cancelNewMeetingButton"].tap()
    let tabLabel = app.staticTexts["newMeetingSheet"]
    XCTAssert(!tabLabel.exists)
  }

  func test_MeetingsView_AddMeeting() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Meetings"].tap()
    app.navigationBars["Meetings"].buttons["Add"].tap()
    let mttxt = app.textFields["meetingTitleLabel"]
    mttxt.tap()
    mttxt.typeText("April Meeting")
    let bktxt = app.textFields["bookTitleLabel"]
    bktxt.tap()
    bktxt.typeText("The Hobbit")
    app.buttons["addNewMeetingButton"].tap()
    let tabLabel = app.staticTexts["April Meeting"]
    XCTAssert(tabLabel.exists)
  }

  func test_Settings_DarkModeToggle() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Settings"].tap()
    let dakrModeVal = isDarkModeOn ? 1 : 0
    XCTAssertTrue(app.switches["darkModeToggle"].value as? String == String(dakrModeVal))
  }

  func test_BooksView_RowExists() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Find"].tap()
    tabBar.buttons["Meetings"].tap()
    tabBar.buttons["Find"].tap()
    let tabLabel = app.staticTexts["booksList.bookrow"]
    XCTAssert(tabLabel.exists)
  }

  func test_BooksView_Exists() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Find"].tap()
    tabBar.buttons["Meetings"].tap()
    tabBar.buttons["Find"].tap()
    app.buttons.matching(identifier: "booksList.bookrow-booksList.bookrow").element(boundBy: 0).tap()
    let tabLabel = app.staticTexts["BookViewLabel"]
    XCTAssert(tabLabel.exists)
  }

  func test_BooksView_AddBook() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Find"].tap()
    app.buttons.matching(identifier: "booksList.bookrow-booksList.bookrow").element(boundBy: 0).tap()
    app.buttons.matching(identifier: "BookViewLabel").element.tap()
    app.buttons["Back"].tap()
    tabBar.buttons["Read Books"].tap()
    let tabLabel = app.staticTexts["readBooksList.book"]
    XCTAssert(tabLabel.exists)
  }

  func test_BooksView_AddBook_Repeat() throws {
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Find"].tap()
    app.buttons.matching(identifier: "booksList.bookrow-booksList.bookrow").element(boundBy: 0).tap()
    app.buttons.matching(identifier: "BookViewLabel").element.tap()
    app.buttons.matching(identifier: "BookViewLabel").element.tap()
    var repeatButton = app.buttons.matching(identifier: "bookRepeatedLabel").element
    XCTAssert(repeatButton.exists)
  }
}
