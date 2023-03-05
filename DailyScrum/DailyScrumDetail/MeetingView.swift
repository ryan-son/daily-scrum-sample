//
//  MeetingView.swift
//  DailyScrum
//
//  Created by Geonhee on 2023/03/05.
//

import SwiftUI

struct MeetingView: View {
  let meeting: Meeting
  let dailyScrum: DailyScrum

  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Divider()
          .padding(.bottom)
        Text("Attendees")
          .font(.headline)
        ForEach(self.dailyScrum.attendees) { attendee in
          Text(attendee.name)
        }
        Text("Transcript")
          .font(.headline)
          .padding(.top)
        Text(self.meeting.transcript)
      }
    }
    .navigationTitle(
      Text(self.meeting.date, style: .date)
    )
    .padding()
  }
}

struct MeetingView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      MeetingView(
        meeting: DailyScrum.mock.meetings[0],
        dailyScrum: .mock
      )
    }
  }
}
