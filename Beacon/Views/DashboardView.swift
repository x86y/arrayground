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
            ScrollView(.horizontal, showsIndicators: false) {
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
                        HStack {
                            Image(systemName: "plus")
                            Text("New")
                        }
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
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 4, x: 2, y: 2)
                    .frame(width: 300, height: 200)
                
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
                            self.tempSnippet = ""
                            self.card.snippet = ""
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                                .foregroundColor(.green)
                        }
                        .padding(.trailing)
                    }
                    if self.card.snippet.isEmpty {
                        TextField("snippet", text: $tempSnippet, onCommit: {
                            self.card.snippet = self.tempSnippet
                            self.updater.snippet = self.card.snippet
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    } else {
                        Text(updater.output)
                            .font(.body)
                    }
                }
                .padding()
            }
        }
    }
    
    class Updater: ObservableObject {
        var snippet: String = ""
        @Published var output: String = ""
        var timer: Timer?
        
        init() {
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { _ in
                self.refresh()
            })
        }
        
        deinit {
            timer?.invalidate()
        }
        
        func refresh() {
            output = UserDefaults.standard.integer(forKey: "lang") == Language.bqn.rawValue
            ? e(input: self.snippet)
            : ke(input: self.snippet)
        }
    }
}

