//
//  ContentView.swift
//  BQN
//
//
//

import Combine
import Foundation
import SwiftUI
import UIKit

let d = UserDefaults.standard

struct Entry: Hashable, Codable, Identifiable {
    var id: String = UUID().uuidString
    var src: String
    var out: String
}

enum Buffers {
    static let k = "history"
    static func save(_ value: [String: [Entry]]) {
        d.set(try? PropertyListEncoder().encode(value), forKey: k)
    }

    static func get() -> [String: [Entry]] {
        guard let data = d.object(forKey: k) as? Data else { return ["default": []] }
        do {
            let userData = try PropertyListDecoder().decode([String: [Entry]].self, from: data)
            return userData
        } catch {
            print("Error decoding the history: \(error)")
            return ["default": []]
        }
    }

    static func clear() {
        d.removeObject(forKey: k)
    }
}

class HistoryModel: ObservableObject {
    @Published var history: [String: [Entry]] = ["default": []]

    func addMessage(with src: String, out: String, for key: String) {
        let entry = Entry(src: src, out: out)
        if var entries = history[key] {
            entries.append(entry)
            history[key] = entries
        } else {
            history[key] = [entry]
        }
        Buffers.save(history)
    }

    func load(_ h: [String: [Entry]]) {
        history = h
    }

    func clear() {
        history = [:]
        Buffers.clear()
    }
}

struct ContentView: View {
    @State var input: String = ""
    @State var ephemerals: [Int: [String]] = [:]
    @State var showSettings: Bool = false
    @State var showHelp: Bool = false
    @State var showBuffers: Bool = false
    @State var curBuffer: String = "default"
    @State var inpPos: Int = -1
    @State var move: (Int) -> Void = { _ in }
    @AppStorage("langSelection") private var chosenLang: Int = 0
    @FocusState var isFocused: Bool
    @ObservedObject var viewModel = HistoryModel()

    func onMySubmit(input: String) {
        if input == "config" {
            showSettings = true
            self.input = ""
            return
        }
        if input == #"\:"# {
            showHelp = true
            return
        }
        if input == "clear" {
            viewModel.clear()
            self.input = ""
            return
        }
        if input == #"\,l"# {
            showBuffers = true
            self.input = ""
            return
        }
        if input.hasPrefix(#"\,"#) {
            let components = input.components(separatedBy: " ")
            if let lastWord = components.last {
                curBuffer = lastWord
            }
            self.input = ""
            return
        }
        if input != "" {
            if chosenLang == 0 {
                viewModel.addMessage(with: input, out: e(input: input), for: curBuffer)
            } else {
                viewModel.addMessage(with: input, out: ke(input: input), for: curBuffer)
            }
            self.input = ""
        }
    }

    var body: some View {
        ScrollViewReader { scrollView in
            VStack {
                ScrollView(.vertical) {
                    VStack {
                        ForEach(Array(viewModel.history[curBuffer, default: []].enumerated()), id: \.offset) { index, h in
                            VStack(alignment: .leading) {
                                TextField("Source", text: Binding(
                                    get: { self.viewModel.history[curBuffer, default: []][index].src },
                                    set: {
                                        self.viewModel.history[curBuffer, default: []][index].src = $0
                                        ephemerals[index, default: []].append($0)
                                    }
                                ))
                                .onSubmit {
                                    onMySubmit(input: self.viewModel.history[curBuffer, default: []][index].src)
                                    for k in ephemerals.keys {
                                        self.viewModel.history[curBuffer, default: []][k].src = ephemerals[k, default: []].first!
                                    }
                                    ephemerals = [:] // reset all virtual textfield edits
                                }
                                .font(Font.custom("BQN386 Unicode", size: 18))
                                .foregroundColor(.blue)
                                Text("\(trimLongText(h.out))")
                                    .font(Font.custom("BQN386 Unicode", size: 18))
                                    .foregroundColor(h.out.starts(with: "Error:") ? .red : .primary)
                                    .multilineTextAlignment(.leading)
                                    .onTapGesture {
                                        self.input += h.out
                                    }
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }.listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }.id("HistoryScrollView")
                        .onChange(of: viewModel.history) { _ in
                            withAnimation {
                                scrollView.scrollTo("HistoryScrollView", anchor: .bottom)
                            }
                        }
                }
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .onTapGesture {
                    isFocused = false
                }
                .padding(.bottom, 5)

            CustomInputField(text: $input,
                             onSubmit: { onMySubmit(input: self.input) },
                             font: UIFont(name: "BQN386 Unicode", size: 20)!,
                             keyboardType: .asciiCapable)
                .frame(height: 24)
                .focused($isFocused)
                .padding()
                .onTapGesture {
                    isFocused = true
                    scrollView.scrollTo("HistoryScrollView", anchor: .bottom)
                }
                .onReceive(Just(input)) { newV in
                    let oldCurPos = self.inpPos
                    newV.matchingStrings(regex: "\\\\[a-zA-Z0-9]").forEach { NSR in
                        let range = Range(NSR[0], in: newV)!
                        if let res = characterMap[String(newV[range])] {
                            let mod = newV.replacingCharacters(in: range, with: String(res))
                            self.input = mod
                        }
                        self.move(oldCurPos)
                    }
                }
            /*
             .toolbar {
             ToolbarItemGroup(placement: .keyboard) {
             ScrollView(.horizontal) {
             HStack {
             ForEach(glyphs, id: \.self) { glyph in
             Button(glyph) {
             print(glyph)
             }
             .font(Font.custom("BQN386 Unicode", size: 30))
             }
             }
             }
             }
             }
             */
        }
        .padding(.top, 0.1)
        .sheet(isPresented: $showSettings) {
            ConfigView()
                .presentationDetents([.large])
        }
        .sheet(isPresented: $showHelp) {
            HelpView(key: self.$input)
                .presentationDetents([.large])
        }
        .sheet(isPresented: $showBuffers) {
            BufferBrowserView(buffers: Array(viewModel.history.keys), sel: self.$curBuffer)
                .presentationDetents([.medium])
        }
        .onAppear(perform: initRepl)
    }

    func initRepl() {
        viewModel.load(Buffers.get())
        kinit()
        repl_init()
        /* for filename in modules {
         print(e(input: "•Import \"\(Bundle.main.resourcePath!)/bqn-libs/\(filename)\""))
         } */
        isFocused = true
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
