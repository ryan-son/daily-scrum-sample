//
//  ContentView.swift
//  DailyScrum
//
//  Created by Geonhee on 2023/02/26.
//

import SwiftUI
import SwiftUINavigation

final class DailyScrumListModel: ObservableObject {
  @Published var dailyScrums: [DailyScrum] = []
  @Published var destination: Destination?

  enum Destination {
    case add(EditDailyScrumModel)
    case detail(DailyScrumDetailModel)
  }

  init(
    destination: Destination? = nil,
    dailyScrums: [DailyScrum] = []
  ) {
    self.destination = destination
    self.dailyScrums = dailyScrums
  }

  func addDailyScrumButtonTapped() {
    self.destination = .add(
      EditDailyScrumModel(
        dailyScrum: DailyScrum(id: DailyScrum.ID(UUID())))
      )
  }

  func dismissEditDailyScrumButtonTapped() {
    self.destination = nil
  }

  func addEditDailyScrumButtonTapped() {
    guard case let .add(editModel) = destination else { return }
//    let newDailyScrum = dailyScrum.attendees.removeAll(where: { $0.name.allSatisfy(\.isWhitespace)
//    })
    dailyScrums.append(editModel.dailyScrum)
    self.destination = nil
  }

  func dailyScrumTapped(_ dailyScrum: DailyScrum) {
    self.destination = .detail(
      DailyScrumDetailModel(dailyScrum: dailyScrum)
    )
  }
}

struct DailyScrumListView: View {
  @ObservedObject var model: DailyScrumListModel

  var body: some View {
    NavigationStack {
      List {
        ForEach(self.$model.dailyScrums) { $dailyScrum in
          Button {
            self.model.dailyScrumTapped(dailyScrum)
          } label: {
            CardView(dailyScrum: dailyScrum)
          }
        }
      }
      .navigationTitle("Daily Scrums List")
      .toolbar {
        Button {
          self.model.addDailyScrumButtonTapped()
        } label: {
          Image(systemName: "plus")
        }
      }
      .sheet(
        unwrapping: self.$model.destination,
        case: /DailyScrumListModel.Destination.add
      ) { $editModel in
        NavigationStack {
          EditDailyScrumView(model: editModel)
            .toolbar {
              ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                  self.model.dismissEditDailyScrumButtonTapped()
                }
              }
              ToolbarItem(placement: .confirmationAction) {
                Button("Add") {
                  self.model.addEditDailyScrumButtonTapped()
                }
              }
            }
        }
      }
      .navigationDestination(
        unwrapping: self.$model.destination,
        case: /DailyScrumListModel.Destination.detail
      ) { $detailModel in
        DailyScrumDetailView(model: detailModel)
      }
    }
  }
}

struct CardView: View {
  let dailyScrum: DailyScrum

  var body: some View {
    VStack(alignment: .leading) {
      Text(self.dailyScrum.title)
        .font(.headline)
      Spacer()
      HStack {
        Label(
          "\(self.dailyScrum.attendees.count)",
          systemImage: "person.3"
        )
        Spacer()
        Label(
          self.dailyScrum.duration.formatted(.units()),
          systemImage: "clock"
        )
        .labelStyle(.trailingIcon)
      }
      .font(.caption)
    }
    .padding()
    .foregroundColor(self.dailyScrum.theme.accentColor)
  }
}

struct TrailingIconLabelStyle: LabelStyle {
  func makeBody(
    configuration: Configuration
  ) -> some View {
    HStack {
      configuration.title
      configuration.icon
    }
  }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
  static var trailingIcon: Self { Self() }
}

struct DailyScrumListView_Previews: PreviewProvider {
  static var previews: some View {
    DailyScrumListView(
      model: DailyScrumListModel(
//        destination: .add(
//          EditDailyScrumModel(
//            dailyScrum: .mock,
//            focus: .attendee(DailyScrum.mock.attendees[3].id)
//          )
//        ),
        dailyScrums: [.mock]
      )
    )
  }
}
