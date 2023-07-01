//
//  GeneratedView.swift
//  Beacon
//

import Charts
import Foundation
import SwiftUI

struct DataElement: Identifiable, Comparable {
    var id = UUID()
    let key: String
    let value: Int

    static func < (lhs: DataElement, rhs: DataElement) -> Bool {
        return lhs.key < rhs.key
    }

    static func == (lhs: DataElement, rhs: DataElement) -> Bool {
        return lhs.key == rhs.key
    }
}

struct Card: Identifiable, Codable {
    let id: UUID
    var snippet: String
}

func parseData(s: String) -> [String: Int] {
    if s != "" {
        let components = s.components(separatedBy: "!")
        let keysString = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "()\""))
        let valuesString = components[1]
        let keys = keysString.components(separatedBy: ";")
        let values = valuesString.split(separator: " ").map { Int($0)! }
        assert(keys.count == values.count, "Keys and values count mismatch!")
        var dict: [String: Int] = [:]
        for (index, key) in keys.enumerated() {
            dict[key.replacingOccurrences(of: "\"", with: #""#)] = values[index]
        }
        return dict
    } else {
        return [:]
    }
}

class DashboardViewModel: ObservableObject {
    @Published var cards: [Card] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(cards) {
                UserDefaults.standard.set(encoded, forKey: "cards")
            }
        }
    }

    init() {
        if let cardsData = UserDefaults.standard.data(forKey: "cards") {
            let decoder = JSONDecoder()
            if let loadedCards = try? decoder.decode([Card].self, from: cardsData) {
                cards = loadedCards
                return
            }
        }
        cards = [Card(id: UUID(), snippet: "")]
    }
}

struct Dashboard: View {
    @StateObject var viewModel = DashboardViewModel()
    var body: some View {
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(0 ..< viewModel.cards.count, id: \.self) { index in
                        CardView(card: $viewModel.cards[index], removeCard: {
                            viewModel.cards.remove(at: index)
                        })
                        .padding(.horizontal)
                    }

                    Button(action: {
                        viewModel.cards.append(Card(id: UUID(), snippet: ""))
                    }) {
                        HStack { Image(systemName: "plus") }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct CardView: View {
    @Binding var card: Card
    let removeCard: () -> Void
    @State private var barSelection: String?
    @State private var tempSnippet: String = ""
    @State private var isLoading: Bool = false
    @State private var isEditing: Bool = false
    @StateObject var updater: Updater = .init()
    var data: [String: Int] { return parseData(s: updater.output) }

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { self.removeCard() }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                        Button(action: {
                            self.isEditing = true
                            updater.deinit_timer()
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                                .foregroundColor(.green)
                        }
                        .padding(.trailing)
                    }
                    if self.isEditing || self.card.snippet.isEmpty {
                        TextEditor(text: $tempSnippet)
                            .padding(.horizontal)
                            .navigationTitle("snippet")
                            .onChange(of: tempSnippet) {
                                if tempSnippet.suffix(2) == "\n\n" {
                                    self.card.snippet = self.tempSnippet
                                    self.isEditing = false
                                    self.updater.snippet = self.card.snippet
                                    updater.init_timer()
                                }
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(Font.system(.body, design: .monospaced))
                            .foregroundColor(.accentColor) // Text color
                            .frame(width: 350, height: 350)
                            .border(.yellow)
                            .padding()
                    } else {
                        ZStack {
                            if updater.isLoading {
                                ProgressView().frame(width: 350, height: 350)
                            }
                            VStack {
                                VStack {
                                    if !updater.output.contains("Error") && updater.output.contains("!") { // FIXME: need a better check if the output is a dict
                                        Chart {
                                            ForEach(data.map { DataElement(key: $0.key, value: $0.value) }.sorted()) { item in
                                                BarMark(
                                                    x: .value("Key", item.key),
                                                    y: .value("Count", item.value)
                                                )
                                                .cornerRadius(8)
                                                .foregroundStyle(by: .value("Result Color", item.key))
                                            }
                                            if let barSelection {
                                                RuleMark(x: .value("Key", barSelection))
                                                    .foregroundStyle(.gray.opacity(0.35))
                                                    .zIndex(-10)
                                                    .offset(yStart: -15)
                                                    .annotation(
                                                        position: .top,
                                                        spacing: 0,
                                                        overflowResolution: .init(x: .disabled, y: .disabled)
                                                    ) {
                                                        ChartPopOverView(xval: barSelection, yval: data[barSelection] ?? 0)
                                                    }
                                            }
                                        }
                                        .chartXSelection(value: $barSelection)
                                        .chartLegend(position: .bottom, alignment: .leading, spacing: 25)
                                        .padding(.all, 15)
                                        .chartYAxis {
                                            AxisMarks(position: .leading) { _ in
                                                AxisValueLabel()
                                            }
                                        }
                                        .chartXAxis {
                                            AxisMarks(position: .bottom) { _ in
                                                AxisValueLabel()
                                            }
                                        }
                                    } else {
                                        Text(updater.output)
                                            .font(.body)
                                            .padding()
                                        Spacer()
                                    }
                                    /*
                                     ProgressView(value: updater.timeRemaining, total: updater.refreshRate)
                                     .accentColor(.green)
                                     .frame(height: 8.0)
                                     .scaleEffect(x: 1, y: 2, anchor: .center)
                                     */
                                }
                                .frame(width: 350, height: 350)
                            }
                        }
                        // .border(.blue)
                    }
                }
                .padding()
            }
        }.onAppear(perform: {
            if !card.snippet.isEmpty {
                updater.snippet = card.snippet
                updater.init_timer()
            }
        })
    }

    @ViewBuilder
    func ChartPopOverView(xval: String, yval: Int) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 4) {
                Text(String(yval))
                    .font(.title3)
                Text(xval)
                    .font(.title3)
                    .textScale(.secondary)
            }
        }
        .padding()
        .background(.cyan, in: .rect(cornerRadius: 8))
    }
}

class Updater: ObservableObject {
    var snippet: String = ""
    var refreshRate: Double = 15.0
    @Published var timeRemaining: Double = 0.0
    @Published var output: String = ""
    @Published var isLoading: Bool = false
    var timer: Timer?

    deinit {
        timer?.invalidate()
    }

    func init_timer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if self.timeRemaining == self.refreshRate {
                Task {
                    await self.refresh()
                }
                self.timeRemaining = 0.0
            } else {
                self.timeRemaining += 1.0
            }
        })
        Task {
            await self.refresh()
        }
    }

    func deinit_timer() {
        timer?.invalidate()
    }

    func refresh() async {
        isLoading = true
        let snippets = snippet.split(separator: "\n")
        var to: String
        for snippet in snippets {
            to = UserDefaults.standard.integer(forKey: "lang") == Language.bqn.rawValue
                ? e(input: String(snippet))
                : ke(input: String(snippet))
            if snippet == snippets.last {
                output = to
            }
        }
        isLoading = false
    }
}
