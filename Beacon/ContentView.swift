//
//  ContentView.swift
//  BQN
//
//  
//

import Combine
import SwiftUI
import UIKit

let d = UserDefaults.standard

struct Entry: Hashable, Codable, Identifiable {
    var id: String = UUID().uuidString
    var src: String
    var out: String
}

enum EntryCache {
    static let k = "history"
    static func save(_ value: [Entry]!) {
        d.set(try? PropertyListEncoder().encode(value), forKey: k)
    }

    static func get() -> [Entry]! {
        guard let o = d.object(forKey: k) as? Data else { return [] }
        do {
            let userData: [Entry] = try PropertyListDecoder().decode([Entry].self, from: o)
            return userData
        } catch {
            // print("Error decoding the history: \(error)")
            return nil
        }
    }

    static func clear() {
        d.removeObject(forKey: k)
    }
}

class HistoryModel: ObservableObject {
    @Published var history: [Entry] = .init()
    func addMessage(with src: String, out: String) {
        let e = Entry(src: src, out: out)
        history.append(e)
        EntryCache.save(history)
    }

    func load(h: [Entry]) {
        history = h
    }

    func clear() {
        history = []
        EntryCache.clear()
    }
}

struct ContentView: View {
    var glyphs = ["˜", "˘", "¨", "⁼", "⌜", "´", "˝", "∞", "¯", "•", "÷", "×", "¬", "⎉", "⚇", "⍟", "◶", "⊘", "⎊", "⍎", "⍕", "⟨", "⟩", "√", "⋆", "←", "→", "⊣", "⊢", "⋄", "↩", "·", "|", "∾", "≍", "≠", "‿"]
    var modules = ["bigint.bqn", "bignat.bqn", "csv.bqn", "datetime.bqn", "hashmap.bqn", "matrix.bqn", "min.bqn", "perlin.bqn", "polynomial.bqn", "primes.bqn", "roots.bqn", "strings.bqn"]
    let characterMap: [String: Character] = ["\\`": "˜", "\\1": "˘", "\\2": "¨", "\\3": "⁼", "\\4": "⌜", "\\5": "´", "\\6": "˝", "\\7": "7", "\\8": "∞", "\\9": "¯", "\\0": "•", "\\-": "÷", "\\=": "×", "\\~": "¬", "\\!": "⎉", "\\@": "⚇", "\\#": "⍟", "\\$": "◶", "\\%": "⊘", "\\^": "⎊", "\\&": "⍎", "\\*": "⍕", "\\(": "⟨", "\\)": "⟩", "\\_": "√", "\\+": "⋆", "\\q": "⌽", "\\w": "𝕨", "\\e": "∊", "\\r": "↑", "\\t": "∧", "\\y": "y", "\\u": "⊔", "\\i": "⊏", "\\o": "⊐", "\\p": "π", "\\[": "←", "\\]": "→", "\\Q": "↙", "\\W": "𝕎", "\\E": "⍷", "\\R": "𝕣", "\\T": "⍋", "\\Y": "Y", "\\U": "U", "\\I": "⊑", "\\O": "⊒", "\\P": "⍳", "\\{": "⊣", "\\}": "⊢", "\\a": "⍉", "\\s": "𝕤", "\\d": "↕", "\\f": "𝕗", "\\g": "𝕘", "\\h": "⊸", "\\j": "∘", "\\k": "○", "\\l": "⟜", "\\;": "⋄", "\\'": "↩", "\\A": "↖", "\\S": "𝕊", "\\D": "D", "\\F": "𝔽", "\\G": "𝔾", "\\H": "«", "\\J": "J", "\\K": "⌾", "\\L": "»", "\\:": "·", "\\|": "|", "\\z": "⥊", "\\x": "𝕩", "\\c": "↓", "\\v": "∨", "\\b": "⌊", "\\n": "n", "\\m": "≡", "\\,": "∾", "\\.": "≍", "\\/": "≠", "\\Z": "⋈", "\\X": "𝕏", "\\C": "C", "\\V": "⍒", "\\B": "⌈", "\\N": "N", "\\M": "≢", "\\<": "≤", "\\>": "≥", "\\?": "⇐", "\\ ": "‿"]

    @State var input: String = ""
    @State var showSettings: Bool = false
    @State var showHelp: Bool = false
    @State var inpPos: Int = -1
    @State var move: (Int) -> Void = { _ in }
    @State var tf: UITextField = .init()
    @State private var history: [Entry] = []
    @AppStorage("langSelection") private var chosenLang: Int = 0
    @FocusState var isFocused: Bool
    @ObservedObject var viewModel = HistoryModel()

    var body: some View {
        ScrollViewReader { scrollView in
            VStack {
                ScrollView(.vertical) {
                    VStack {
                        ForEach(Array(viewModel.history.enumerated()), id: \.offset) { _, h in
                            VStack(alignment: .leading) {
                                Text("\(h.src)")
                                    .font(Font.custom("BQN386 Unicode", size: 18))
                                    .foregroundColor(.blue)
                                    .multilineTextAlignment(.leading)
                                    .onTapGesture {
                                        self.input = h.src
                                    }
                                Text("\(trimLongText(h.out))")
                                    .font(Font.custom("BQN386 Unicode", size: 18))
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

            CustomInputField(text: $input, onSubmit: {
                if input == "config" {
                    self.showSettings = true
                    self.input = ""
                    return
                }
                if input == #"\:"# {
                    self.showHelp = true
                    return
                }
                if input == "clear" {
                    viewModel.clear()
                    self.input = ""
                    return
                }
                if input != "" {
                    if chosenLang == 0 {
                        self.viewModel.addMessage(with: self.input, out: e(input: self.input))
                    } else {
                        self.viewModel.addMessage(with: self.input, out: ke(input: self.input))
                    }
                    self.input = ""
                }
            }, font: UIFont(name: "BQN386 Unicode", size: 20)!, keyboardType: .asciiCapable)
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
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(glyphs, id: \.self) { glyph in
                                    Button(glyph) {
                                        self.tf.insertText(glyph)
                                    }
                                    .font(Font.custom("BQN386 Unicode", size: 30))
                                }
                            }
                        }
                    }
                }
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
        .onAppear(perform: initRepl)
    }

    func initRepl() {
        if EntryCache.get() != nil {
            viewModel.load(h: EntryCache.get())
        }
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
