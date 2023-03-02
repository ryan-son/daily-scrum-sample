//
//  EditDailyScrumTests.swift
//  DailyScrumTests
//
//  Created by Geonhee on 2023/03/02.
//

import XCTest

@testable import DailyScrum

final class EditDailyScrumTests: XCTestCase {

  func testDeleteAttendee() {
    let model = EditDailyScrumModel(
      dailyScrum: DailyScrum(
        id: DailyScrum.ID(UUID()),
        attendees: [
          Attendee(id: Attendee.ID(UUID()), name: "Coda"),
          Attendee(id: Attendee.ID(UUID()), name: "Ryan"),
        ]
      )
    )

    model.deleteAttendeeButtonTapped(atOffsets: [1])

    XCTAssertEqual(model.dailyScrum.attendees.count, 1)
    XCTAssertEqual(model.dailyScrum.attendees[0].name, "Coda")
  }

  func testAddAttendee() {
    let model = EditDailyScrumModel(
      dailyScrum: DailyScrum(
        id: DailyScrum.ID(UUID())
      )
    )

    XCTAssertEqual(model.dailyScrum.attendees.count, 1)
    XCTAssertEqual(model.focus, .title)

    model.addAttendeeButtonTapped()

    XCTAssertEqual(model.dailyScrum.attendees.count, 2)
    XCTAssertEqual(model.focus, .attendee(model.dailyScrum.attendees[1].id))
  }
}
