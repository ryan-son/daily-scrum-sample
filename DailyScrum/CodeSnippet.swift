//
//  CodeSnippet.swift
//  DailyScrum
//
//  Created by Geonhee on 2023/02/26.
//

// MARK: - Models

//struct DailyScrum: Equatable, Identifiable, Codable {
//  let id: UUID
//  var attendees: [Attendee] = []
//  var duration = Duration.seconds(60 * 5)
//  var meetings: [Meeting] = []
//  var theme: Theme = .bubblegum
//  var title = ""
//
//  var durationPerAttendee: Duration {
//    self.duration / self.attendees.count
//  }
//}
//
//struct Attendee: Equatable, Identifiable, Codable {
//  let id: UUID
//  var name: String
//}
//
//struct Meeting: Equatable, Identifiable, Codable {
//  let id: UUID
//  let date: Date
//  var transcript: String
//}
//
//enum Theme:
//  String,
//  CaseIterable,
//  Equatable,
//  Hashable,
//  Identifiable,
//  Codable
//{
//  case bubblegum
//  case buttercup
//  case indigo
//  case lavender
//  case magenta
//  case navy
//  case orange
//  case oxblood
//  case periwinkle
//  case poppy
//  case purple
//  case seafoam
//  case sky
//  case tan
//  case teal
//  case yellow
//
//  var id: Self { self }
//
//  var accentColor: Color {
//    switch self {
//    case
//      .bubblegum,
//      .buttercup,
//      .lavender,
//      .orange,
//      .periwinkle,
//      .poppy,
//      .seafoam,
//      .sky,
//      .tan,
//      .teal,
//      .yellow:
//
//      return .black
//    case .indigo, .magenta, .navy, .oxblood, .purple:
//      return .white
//    }
//  }
//
//  var mainColor: Color { Color(self.rawValue) }
//
//  var name: String { self.rawValue.capitalized }
//}

// MARK: - Card View

//struct CardView: View {
//  let dailyScrum: DailyScrum
//
//  var body: some View {
//    VStack(alignment: .leading) {
//      Text(self.dailyScrum.title)
//        .font(.headline)
//      Spacer()
//      HStack {
//        Label(
//          "\(self.dailyScrum.attendees.count)",
//          systemImage: "person.3"
//        )
//        Spacer()
//        Label(
//          self.dailyScrum.duration.formatted(.units()),
//          systemImage: "clock"
//        )
//        .labelStyle(.trailingIcon)
//      }
//      .font(.caption)
//    }
//    .padding()
//    .foregroundColor(self.dailyScrum.theme.accentColor)
//  }
//}
//
//struct TrailingIconLabelStyle: LabelStyle {
//  func makeBody(
//    configuration: Configuration
//  ) -> some View {
//    HStack {
//      configuration.title
//      configuration.icon
//    }
//  }
//}
//
//extension LabelStyle where Self == TrailingIconLabelStyle {
//  static var trailingIcon: Self { Self() }
//}

// MARK: - Daily Scrum Mock

//extension DailyScrum {
//  static let mock = Self(
//    id: DailyScrum.ID(UUID()),
//    attendees: [
//      Attendee(id: Attendee.ID(UUID()), name: "Blob"),
//      Attendee(id: Attendee.ID(UUID()), name: "Blob Jr"),
//      Attendee(id: Attendee.ID(UUID()), name: "Blob Sr"),
//      Attendee(id: Attendee.ID(UUID()), name: "Blob Esq"),
//      Attendee(id: Attendee.ID(UUID()), name: "Blob III"),
//      Attendee(id: Attendee.ID(UUID()), name: "Blob I"),
//    ],
//    duration: .seconds(60),
//    meetings: [
//      Meeting(
//        id: Meeting.ID(UUID()),
//        date: Date().addingTimeInterval(-60 * 60 * 24 * 7),
//        transcript: """
//          Lorem ipsum dolor sit amet, consectetur \
//          adipiscing elit, sed do eiusmod tempor \
//          incididunt ut labore et dolore magna aliqua. \
//          Ut enim ad minim veniam, quis nostrud \
//          exercitation ullamco laboris nisi ut aliquip \
//          ex ea commodo consequat. Duis aute irure \
//          dolor in reprehenderit in voluptate velit \
//          esse cillum dolore eu fugiat nulla pariatur. \
//          Excepteur sint occaecat cupidatat non \
//          proident, sunt in culpa qui officia deserunt \
//          mollit anim id est laborum.
//          """
//      )
//    ],
//    theme: .orange,
//    title: "Design"
//  )
//}

// MARK: - Add Daily Scrum Button

//.toolbar {
//  Button {
//    self.model.addDailyScrumButtonTapped()
//  } label: {
//    Image(systemName: "plus")
//  }
//}

// MARK: - Edit Daily Scrum View

//struct EditDailyScrumView: View {
//  @Binding var dailyScrum: DailyScrum
//
//  var body: some View {
//    Form {
//      Section {
//        TextField("Title", text: self.$dailyScrum.title)
//        HStack {
//          Slider(
//            value: self.$dailyScrum.duration.seconds,
//            in: 5...30, step: 1
//          ) {
//            Text("Length")
//          }
//          Spacer()
//          Text(self.dailyScrum.duration.formatted(.units()))
//        }
//        ThemePicker(selection: self.$dailyScrum.theme)
//      } header: {
//        Text("dailyScrum Info")
//      }
//      Section {
//        ForEach(self.$dailyScrum.attendees) { $attendee in
//          TextField("Name", text: $attendee.name)
//        }
//        .onDelete { indices in
//          self.dailyScrum.attendees.remove(
//            atOffsets: indices
//          )
//          if self.dailyScrum.attendees.isEmpty {
//            self.dailyScrum.attendees.append(
//              Attendee(id: Attendee.ID(UUID()), name: "")
//            )
//          }
//        }
//
//        Button("New attendee") {
//          self.dailyScrum.attendees.append(
//            Attendee(id: Attendee.ID(UUID()), name: "")
//          )
//        }
//      } header: {
//        Text("Attendees")
//      }
//    }
//    .onAppear {
//      if self.dailyScrum.attendees.isEmpty {
//        self.dailyScrum.attendees.append(
//          Attendee(id: Attendee.ID(UUID()), name: "")
//        )
//      }
//    }
//  }
//}
//
//struct ThemePicker: View {
//  @Binding var selection: Theme
//
//  var body: some View {
//    Picker("Theme", selection: $selection) {
//      ForEach(Theme.allCases) { theme in
//        ZStack {
//          RoundedRectangle(cornerRadius: 4)
//            .fill(theme.mainColor)
//          Label(theme.name, systemImage: "paintpalette")
//            .padding(4)
//        }
//        .foregroundColor(theme.accentColor)
//        .fixedSize(horizontal: false, vertical: true)
//        .tag(theme)
//      }
//    }
//  }
//}
//
//extension Duration {
//  fileprivate var seconds: Double {
//    get { Double(self.components.seconds / 60) }
//    set { self = .seconds(newValue * 60) }
//  }
//}

// MARK: - Daily Scrum List View - Edit Daily Scrum View tool bar

//.toolbar {
//  ToolbarItem(placement: .cancellationAction) {
//    Button("Dismiss") {
//    }
//  }
//  ToolbarItem(placement: .confirmationAction) {
//    Button("Add") {
//    }
//  }
//}

// MARK: - Detail View UI

//var body: some View {
//  List {
//    Section {
//      Button {
//      } label: {
//        Label("Start Meeting", systemImage: "timer")
//          .font(.headline)
//          .foregroundColor(.accentColor)
//      }
//      HStack {
//        Label("Length", systemImage: "clock")
//        Spacer()
//        Text(self.model.dailyScrum.duration.formatted(
//          .units())
//        )
//      }
//
//      HStack {
//        Label("Theme", systemImage: "paintpalette")
//        Spacer()
//        Text(self.model.dailyScrum.theme.name)
//          .padding(4)
//          .foregroundColor(
//            self.model.dailyScrum.theme.accentColor
//          )
//          .background(self.model.dailyScrum.theme.mainColor)
//          .cornerRadius(4)
//      }
//    } header: {
//      Text("Daily Scrum Info")
//    }
//
//    if !self.model.dailyScrum.meetings.isEmpty {
//      Section {
//        ForEach(self.model.dailyScrum.meetings) { meeting in
//          Button {
//          } label: {
//            HStack {
//              Image(systemName: "calendar")
//              Text(meeting.date, style: .date)
//              Text(meeting.date, style: .time)
//            }
//          }
//        }
//        .onDelete { indices in
//        }
//      } header: {
//        Text("Past meetings")
//      }
//    }
//
//    Section {
//      ForEach(self.model.dailyScrum.attendees) { attendee in
//        Label(attendee.name, systemImage: "person")
//      }
//    } header: {
//      Text("Attendees")
//    }
//
//    Section {
//      Button("Delete") {
//      }
//      .foregroundColor(.red)
//      .frame(maxWidth: .infinity)
//    }
//  }
//  .navigationTitle(self.model.dailyScrum.title)
//  .toolbar {
//    Button("Edit") {
//    }
//  }
//}

// MARK: - Meeting View

//struct MeetingView: View {
//  let meeting: Meeting
//  let dailyScrum: DailyScrum
//
//  var body: some View {
//    ScrollView {
//      VStack(alignment: .leading) {
//        Divider()
//          .padding(.bottom)
//        Text("Attendees")
//          .font(.headline)
//        ForEach(self.dailyScrum.attendees) { attendee in
//          Text(attendee.name)
//        }
//        Text("Transcript")
//          .font(.headline)
//          .padding(.top)
//        Text(self.meeting.transcript)
//      }
//    }
//    .navigationTitle(
//      Text(self.meeting.date, style: .date)
//    )
//    .padding()
//  }
//}

// MARK: - Detail Edit View tool bar

//.toolbar {
//  ToolbarItem(placement: .cancellationAction) {
//    Button("Cancel") {
//    }
//  }
//  ToolbarItem(placement: .confirmationAction) {
//    Button("Done") {
//    }
//  }
//}

// MARK: - Record View subviews

//struct MeetingHeaderView: View {
//  let secondsElapsed: Int
//  let durationRemaining: Duration
//  let theme: Theme
//
//  var body: some View {
//    VStack {
//      ProgressView(value: self.progress)
//        .progressViewStyle(
//          MeetingProgressViewStyle(theme: self.theme)
//        )
//      HStack {
//        VStack(alignment: .leading) {
//          Text("Seconds Elapsed")
//            .font(.caption)
//          Label(
//            "\(self.secondsElapsed)",
//            systemImage: "hourglass.bottomhalf.fill"
//          )
//        }
//        Spacer()
//        VStack(alignment: .trailing) {
//          Text("Seconds Remaining")
//            .font(.caption)
//          Label(
//            self.durationRemaining.formatted(.units()),
//            systemImage: "hourglass.tophalf.fill"
//          )
//          .font(.body.monospacedDigit())
//          .labelStyle(.trailingIcon)
//        }
//      }
//    }
//    .padding([.top, .horizontal])
//  }
//
//  private var totalDuration: Duration {
//    .seconds(self.secondsElapsed)
//      + self.durationRemaining
//  }
//
//  private var progress: Double {
//    guard totalDuration > .seconds(0) else { return 0 }
//    return Double(self.secondsElapsed)
//      / Double(self.totalDuration.components.seconds)
//  }
//}
//
//struct MeetingProgressViewStyle: ProgressViewStyle {
//  var theme: Theme
//
//  func makeBody(
//    configuration: Configuration
//  ) -> some View {
//    ZStack {
//      RoundedRectangle(cornerRadius: 10.0)
//        .fill(theme.accentColor)
//        .frame(height: 20.0)
//
//      ProgressView(configuration)
//        .tint(theme.mainColor)
//        .frame(height: 12.0)
//        .padding(.horizontal)
//    }
//  }
//}
//
//struct MeetingTimerView: View {
//  let dailyScrum: DailyScrum
//  let speakerIndex: Int
//
//  var body: some View {
//    Circle()
//      .strokeBorder(lineWidth: 24)
//      .overlay {
//        VStack {
//          Text(self.currentSpeakerName)
//            .font(.title)
//          Text("is speaking")
//          Image(systemName: "mic.fill")
//            .font(.largeTitle)
//            .padding(.top)
//        }
//        .foregroundStyle(self.dailyScrum.theme.accentColor)
//      }
//      .overlay {
//        ForEach(
//          Array(self.dailyScrum.attendees.enumerated()),
//          id: \.element.id
//        ) { index, attendee in
//          if index < self.speakerIndex + 1 {
//            SpeakerArc(
//              totalSpeakers: self.dailyScrum.attendees.count,
//              speakerIndex: index
//            )
//            .rotation(Angle(degrees: -90))
//            .stroke(
//              self.dailyScrum.theme.mainColor,
//              lineWidth: 12
//            )
//          }
//        }
//      }
//      .padding(.horizontal)
//  }
//
//  private var currentSpeakerName: String {
//    guard
//      self.speakerIndex < self.dailyScrum.attendees.count
//    else { return "Someone" }
//    return self.dailyScrum
//      .attendees[self.speakerIndex].name
//  }
//}
//
//struct SpeakerArc: Shape {
//  let totalSpeakers: Int
//  let speakerIndex: Int
//
//  private var degreesPerSpeaker: Double {
//    360.0 / Double(totalSpeakers)
//  }
//  private var startAngle: Angle {
//    Angle(
//      degrees: degreesPerSpeaker
//        * Double(speakerIndex)
//        + 1.0
//    )
//  }
//  private var endAngle: Angle {
//    Angle(
//      degrees: startAngle.degrees
//        + degreesPerSpeaker
//        - 1.0
//    )
//  }
//
//  func path(in rect: CGRect) -> Path {
//    let diameter = min(
//      rect.size.width, rect.size.height
//    ) - 24.0
//    let radius = diameter / 2.0
//    let center = CGPoint(x: rect.midX, y: rect.midY)
//    return Path { path in
//      path.addArc(
//        center: center,
//        radius: radius,
//        startAngle: startAngle,
//        endAngle: endAngle,
//        clockwise: false
//      )
//    }
//  }
//}
//
//struct MeetingFooterView: View {
//  let dailyScrum: DailyScrum
//  var nextButtonTapped: () -> Void
//  let speakerIndex: Int
//
//  var body: some View {
//    VStack {
//      HStack {
//        Text(self.speakerText)
//        Spacer()
//        Button(action: self.nextButtonTapped) {
//          Image(systemName: "forward.fill")
//        }
//      }
//    }
//    .padding([.bottom, .horizontal])
//  }
//
//  private var speakerText: String {
//    guard
//      self.speakerIndex
//        < self.dailyScrum.attendees.count - 1
//    else {
//      return "No more speakers."
//    }
//    return """
//      Speaker \(self.speakerIndex + 1) \
//      of \(self.dailyScrum.attendees.count)
//      """
//  }
//}

// MARK: - Record View body

//var body: some View {
//  ZStack {
//    RoundedRectangle(cornerRadius: 16)
//      .fill(<#TODO#>)
//
//    VStack {
//      MeetingHeaderView(
//        secondsElapsed: <#TODO#>,
//        durationRemaining: <#TODO#>,
//        theme: <#TODO#>
//      )
//      MeetingTimerView(
//        dailyScrum: <#TODO#>,
//        speakerIndex: <#TODO#>
//      )
//      MeetingFooterView(
//        dailyScrum: <#TODO#>,
//        nextButtonTapped: { <#TODO#> },
//        speakerIndex: <#TODO#>
//      )
//    }
//  }
//  .padding()
//  .foregroundColor(<#TODO#>)
//  .navigationBarTitleDisplayMode(.inline)
//  .toolbar {
//    ToolbarItem(placement: .cancellationAction) {
//      Button("End meeting") {
//        <#TODO#>
//      }
//    }
//  }
//  .navigationBarBackButtonHidden(true)
//}

// MARK: - Speech

//@preconcurrency import Speech
//
//actor Speech {
//  private var audioEngine: AVAudioEngine? = nil
//  private var recognitionTask: SFSpeechRecognitionTask?
//    = nil
//  private var recognitionContinuation:
//    AsyncThrowingStream<
//      SFSpeechRecognitionResult, Error
//    >.Continuation?
//
//  func startTask(
//    request: SFSpeechAudioBufferRecognitionRequest
//  ) -> AsyncThrowingStream<
//    SFSpeechRecognitionResult, Error
//  > {
//    AsyncThrowingStream { continuation in
//      self.recognitionContinuation = continuation
//      let audioSession = AVAudioSession.sharedInstance()
//      do {
//        try audioSession.setCategory(
//          .record,
//          mode: .measurement,
//          options: .duckOthers
//        )
//        try audioSession.setActive(
//          true,
//          options: .notifyOthersOnDeactivation
//        )
//      } catch {
//        continuation.finish(throwing: error)
//        return
//      }
//
//      self.audioEngine = AVAudioEngine()
//      let speechRecognizer = SFSpeechRecognizer(
//        locale: Locale(identifier: "en-US")
//      )!
//      self.recognitionTask = speechRecognizer
//        .recognitionTask(with: request) {
//          result, error in
//
//          switch (result, error) {
//          case let (.some(result), _):
//            continuation.yield(result)
//          case (_, .some):
//            continuation.finish(throwing: error)
//          case (.none, .none):
//            fatalError(
//              """
//              It should not be possible to have \
//              both a nil result and nil error.
//              """
//            )
//          }
//        }
//
//      continuation.onTermination = {
//        [audioEngine, recognitionTask] _ in
//
//        _ = speechRecognizer
//        audioEngine?.stop()
//        audioEngine?.inputNode.removeTap(onBus: 0)
//        recognitionTask?.finish()
//      }
//
//      self.audioEngine?.inputNode.installTap(
//        onBus: 0,
//        bufferSize: 1024,
//        format: self.audioEngine?.inputNode
//          .outputFormat(forBus: 0)
//      ) { buffer, when in
//        request.append(buffer)
//      }
//
//      self.audioEngine?.prepare()
//      do {
//        try self.audioEngine?.start()
//      } catch {
//        continuation.finish(throwing: error)
//        return
//      }
//    }
//  }
//}
//

// MARK: - Start speech recognition

//let speech = Speech()
//let request = SFSpeechAudioBufferRecognitionRequest()
//
//for try await result in await speech.startTask(request: request) {
//  print(result.bestTranscription.formattedString)
//}

// MARK: - URL Helper

//extension URL {
//  static let dailyScrums = Self.documentsDirectory
//    .appending(component: "dailyScrums.json")
//}


// MARK: - Load from disk

//do {
//  self.dailyScrums = try JSONDecoder().decode(
//    IdentifiedArray.self,
//    from: Data(contentsOf: .dailyScrums)
//  )
//} catch {
//  // TODO: Handle error
//}

// MARK: - Write to disk

//self.$dailyScrums
//  .sink { dailyScrums in
//    do {
//      try JSONEncoder().encode(dailyScrums).write(to: .dailyScrums)
//    } catch {
//
//    }
//  }

// MARK: - remove Persistence

//try? FileManager.default.removeItem(
//  at: .documentsDirectory.appending(
//    component: "standups.json"
//  )
//)
