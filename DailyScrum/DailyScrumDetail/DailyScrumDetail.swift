//
//  DailyScrumDetail.swift
//  DailyScrum
//
//  Created by Geonhee on 2023/03/03.
//

import SwiftUI

final class DailyScrumDetailModel: ObservableObject {
  @Published var dailyScrum: DailyScrum

  init(dailyScrum: DailyScrum) {
    self.dailyScrum = dailyScrum
  }
}

struct DailyScrumDetailView: View {
  @ObservedObject var model: DailyScrumDetailModel

  init(model: DailyScrumDetailModel) {
    self.model = model
  }

  var body: some View {
    List {
      Section {
        Button {
        } label: {
          Label("Start Meeting", systemImage: "timer")
            .font(.headline)
            .foregroundColor(.accentColor)
        }
        HStack {
          Label("Length", systemImage: "clock")
          Spacer()
          Text(self.model.dailyScrum.duration.formatted(
            .units())
          )
        }

        HStack {
          Label("Theme", systemImage: "paintpalette")
          Spacer()
          Text(self.model.dailyScrum.theme.name)
            .padding(4)
            .foregroundColor(
              self.model.dailyScrum.theme.accentColor
            )
            .background(self.model.dailyScrum.theme.mainColor)
            .cornerRadius(4)
        }
      } header: {
        Text("Daily Scrum Info")
      }

      if !self.model.dailyScrum.meetings.isEmpty {
        Section {
          ForEach(self.model.dailyScrum.meetings) { meeting in
            Button {
            } label: {
              HStack {
                Image(systemName: "calendar")
                Text(meeting.date, style: .date)
                Text(meeting.date, style: .time)
              }
            }
          }
          .onDelete { indices in
          }
        } header: {
          Text("Past meetings")
        }
      }

      Section {
        ForEach(self.model.dailyScrum.attendees) { attendee in
          Label(attendee.name, systemImage: "person")
        }
      } header: {
        Text("Attendees")
      }

      Section {
        Button("Delete") {
        }
        .foregroundColor(.red)
        .frame(maxWidth: .infinity)
      }
    }
    .navigationTitle(self.model.dailyScrum.title)
    .toolbar {
      Button("Edit") {
      }
    }
  }
}

struct DailyScrumDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      DailyScrumDetailView(
        model: DailyScrumDetailModel(
          dailyScrum: .mock
        )
      )
    }
  }
}
