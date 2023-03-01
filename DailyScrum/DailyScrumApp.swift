//
//  DailyScrumApp.swift
//  DailyScrum
//
//  Created by Geonhee on 2023/02/26.
//

import SwiftUI

@main
struct DailyScrumApp: App {
  var body: some Scene {
    WindowGroup {
//      DailyScrumListView(model: DailyScrumListModel())
      DailyScrumListView(
        model: DailyScrumListModel(
          destination: .add(
            EditDailyScrumModel(
              dailyScrum: .mock,
              focus: .attendee(DailyScrum.mock.attendees[3].id)
            )
          ),
          dailyScrums: [.mock]
        )
      )
    }
  }
}
