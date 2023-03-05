//
//  DailyScrumDetail.swift
//  DailyScrum
//
//  Created by Geonhee on 2023/03/03.
//

import SwiftUI
import SwiftUINavigation

final class DailyScrumDetailModel: ObservableObject {
  @Published var destination: Destination?
  @Published var dailyScrum: DailyScrum

  enum Destination {
    case edit(EditDailyScrumModel)
    case meeting(Meeting)
  }

  init(
    destination: Destination? = nil,
    dailyScrum: DailyScrum
  ) {
    self.destination = destination
    self.dailyScrum = dailyScrum
  }

  func editButtonTapped() {
    self.destination = .edit(
      EditDailyScrumModel(dailyScrum: self.dailyScrum)
    )
  }

  func editCancelButtonTapped() {
    self.destination = nil
  }

  func editDoneButtonTapped() {
    guard case let .edit(editModel) = destination else { return }
    self.dailyScrum = editModel.dailyScrum
    self.destination = nil
  }

  func meetingTapped(_ meeting: Meeting) {
    self.destination = .meeting(meeting)
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
          Text(self.model.dailyScrum.duration.formatted(.units()))
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
              self.model.meetingTapped(meeting)
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
        self.model.editButtonTapped()
      }
    }
    .sheet(
      unwrapping: self.$model.destination,
      case: /DailyScrumDetailModel.Destination.edit
    ) { $editModel in
      NavigationStack {
        EditDailyScrumView(model: editModel)
          .toolbar {
            ToolbarItem(placement: .cancellationAction) {
              Button("Cancel") {
                self.model.editCancelButtonTapped()
              }
            }
            ToolbarItem(placement: .confirmationAction) {
              Button("Done") {
                self.model.editDoneButtonTapped()
              }
            }
          }
      }
    }
    .navigationDestination(
      unwrapping: self.$model.destination,
      case: /DailyScrumDetailModel.Destination.meeting
    ) { $meeting in
      MeetingView(meeting: meeting, dailyScrum: self.model.dailyScrum)
    }
  }
}

struct DailyScrumDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      DailyScrumDetailView(
        model: DailyScrumDetailModel(
          destination: .edit(
            EditDailyScrumModel(dailyScrum: .mock)
          ),
          dailyScrum: .mock
        )
      )
    }
  }
}
