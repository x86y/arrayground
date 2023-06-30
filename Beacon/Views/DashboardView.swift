//
//  GeneratedView.swift
//  Beacon
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    let id: UUID
    var snippet: String
}

struct Dashboard: View {
    @State private var cards: [Card] = [Card(id: UUID(), snippet: "")]
    var body: some View {
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(0 ..< cards.count, id: \.self) { index in
                        CardView(card: $cards[index], removeCard: {
                            cards.remove(at: index)
                        })
                        .padding(.horizontal)
                    }
                    
                    Button(action: {
                        self.cards.append(Card(id: UUID(), snippet: ""))
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
    @State private var tempSnippet: String = ""
    @StateObject var updater: Updater = Updater()
    
    var body: some View {
        VStack{
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.removeCard()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                        Button(action: {
                            self.card.snippet = ""
                            updater.deinit_timer()
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                                .foregroundColor(.green)
                        }
                        .padding(.trailing)
                    }
                    if self.card.snippet.isEmpty {
                        TextEditor(text: $tempSnippet)
                            .padding(.horizontal)
                            .navigationTitle("snippet")
                            .onChange(of: tempSnippet) {
                                if tempSnippet.suffix(2) == "\n\n" {
                                    self.card.snippet = self.tempSnippet
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
                        Text(updater.output)
                            .frame(width: 350, height: 350)
                            .border(.yellow)
                            .font(.body)
                            .padding()
                    }
                }
                .padding()
            }
        }
    }
}

class Updater: ObservableObject {
    var snippet: String = ""
    @Published var output: String = ""
    var timer: Timer?
    
   deinit {
        timer?.invalidate()
    }
    
    func init_timer() {
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true, block: { _ in
            self.refresh()
        })
        self.refresh()
    }
   func deinit_timer() {
        timer?.invalidate()
    }
    
    func refresh() {
        let snippets = self.snippet.split(separator: "\n")
        var to: String
        for snippet in snippets {
            to = UserDefaults.standard.integer(forKey: "lang") == Language.bqn.rawValue
            ? e(input: String(snippet))
            : ke(input: String(snippet))
            if snippet == snippets.last { output = to }
        }
    }
}
