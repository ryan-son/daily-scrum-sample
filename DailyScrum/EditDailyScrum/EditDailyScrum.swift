//
//  EditDailyScrum.swift
//  DailyScrum
//
//  Created by Geonhee on 2023/02/26.
//

import SwiftUI
import SwiftUINavigation

final class EditDailyScrumModel: ObservableObject {

  enum Field: Hashable {
    case title
    case attendee(Attendee.ID)
  }

  @Published var dailyScrum: DailyScrum
  @Published var focus: Field?

  init(
    dailyScrum: DailyScrum,
    focus: Field? = .title
  ) {
    self.dailyScrum = dailyScrum
    self.focus = focus

    if self.dailyScrum.attendees.isEmpty {
      self.dailyScrum.attendees.append(
        Attendee(id: Attendee.ID(UUID()), name: "")
      )
    }
  }

  func deleteAttendeeButtonTapped(atOffsets indices: IndexSet) {
    self.dailyScrum.attendees.remove(atOffsets: indices)

    if self.dailyScrum.attendees.isEmpty {
      self.dailyScrum.attendees.append(
        Attendee(id: Attendee.ID(UUID()), name: "")
      )
    }
  }

  func addAttendeeButtonTapped() {
    let newAttendee = Attendee(id: Attendee.ID(UUID()), name: "")
    self.dailyScrum.attendees.append(newAttendee)
    self.focus = .attendee(newAttendee.id)
  }
}

struct EditDailyScrumView: View {

  @ObservedObject var model: EditDailyScrumModel
  @FocusState var focus: EditDailyScrumModel.Field?

  var body: some View {
    Form {
      Section {
        TextField("Title", text: self.$model.dailyScrum.title)
          .focused(self.$focus, equals: .title)
          .bind(self.$model.focus, to: self.$focus)
        HStack {
          Slider(
            value: self.$model.dailyScrum.duration.seconds,
            in: 5...30, step: 1
          ) {
            Text("Length")
          }
          Spacer()
          Text(self.model.dailyScrum.duration.formatted(.units()))
        }
        ThemePicker(selection: self.$model.dailyScrum.theme)
      } header: {
        Text("dailyScrum Info")
      }
      Section {
        ForEach(self.$model.dailyScrum.attendees) { $attendee in
          TextField("Name", text: $attendee.name)
            .focused(self.$focus, equals: .attendee(attendee.id))
            .bind(self.$model.focus, to: self.$focus)
        }
        .onDelete { indices in
          self.model.deleteAttendeeButtonTapped(atOffsets: indices)
        }

        Button("New attendee") {
          self.model.addAttendeeButtonTapped()
//          self.focus = .attendee(newAttendee.id)
        }
      } header: {
        Text("Attendees")
      }
    }
    .navigationTitle(self.model.dailyScrum.title)
  }
}

struct ThemePicker: View {
  @Binding var selection: Theme

  var body: some View {
    Picker("Theme", selection: $selection) {
      ForEach(Theme.allCases) { theme in
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .fill(theme.mainColor)
          Label(theme.name, systemImage: "paintpalette")
            .padding(4)
        }
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
        .tag(theme)
      }
    }
  }
}

extension Duration {
  fileprivate var seconds: Double {
    get { Double(self.components.seconds / 60) }
    set { self = .seconds(newValue * 60) }
  }
}

struct EditDailyScrumView_Previews: PreviewProvider {
  static var previews: some View {
    WithState(initialValue: DailyScrum.mock) { $dailyScrum in
      NavigationStack {
        EditDailyScrumView(model: EditDailyScrumModel(dailyScrum: dailyScrum))
      }
    }
  }
}
