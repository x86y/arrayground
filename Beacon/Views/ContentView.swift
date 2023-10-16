//
//  ContentView.swift
//  BQN
//

import Combine
import CoreSpotlight
import Foundation
import MobileCoreServices
import SwiftUI
import UIKit

struct HistoryView: View {
    var index: Int
    var historyItem: Entry
    var curBuffer: String
    var onMySubmit: (String) -> Void
    @Binding var input: String
    @Binding var ephemerals: [Int: [String]]
    @Binding var editType: Behavior
    @ObservedObject var viewModel: HistoryModel

    var body: some View {
        VStack(alignment: .leading) {
            if editType == Behavior.inlineEdit {
                TextField("Source", text: Binding(
                    get: {
                        if index < viewModel.history[curBuffer, default: []].count {
                            return self.viewModel.history[curBuffer, default: []][index].src
                        } else {
                            return ""
                        }
                    },
                    set: {
                        if index < viewModel.history[curBuffer, default: []].count {
                            self.viewModel.history[curBuffer, default: []][index].src = $0
                            ephemerals[index, default: []].append($0)
                        }
                    }
                ))
                .onSubmit {
                    onMySubmit(self.viewModel.history[curBuffer, default: []][index].src)
                    for k in ephemerals.keys {
                        self.viewModel.history[curBuffer, default: []][k].src = ephemerals[k, default: []].first!
                    }
                    ephemerals = [:] // reset all virtual textfield edits
                }
                .font(Font.custom("BQN386 Unicode", size: 18))
                .foregroundColor(.blue)
            } else if editType == Behavior.duplicate {
                VStack(spacing: 1) {
                    let tokens = historyItem.lang == .k
                        ? tokenize(historyItem.src, parseK(historyItem.src))
                        : tokenize(historyItem.src, parseBQN(code: historyItem.src))
                    ForEach(Array(tokens.enumerated()), id: \.offset) { _, line in
                        HStack(spacing: 0) {
                            ForEach(line, id: \.id) { token in
                                Text(token.value)
                                    .foregroundColor(tokenToColor(token.type))
                                    .font(Font.custom("BQN386 Unicode", size: 18))
                                    .onTapGesture {
                                        self.input = historyItem.src
                                    }
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            Text("\(trimLongText(historyItem.out))")
                .font(Font.custom("BQN386 Unicode", size: 18))
                .foregroundColor(historyItem.out.starts(with: "Error:") || historyItem.out.starts(with: "\"Error:") ? .red : .primary)
                .multilineTextAlignment(.leading)
                .onTapGesture {
                    self.input = historyItem.out
                }
        }.frame(maxWidth: .infinity, alignment: .leading)
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
    @AppStorage("lang") var lang: Language = .bqn
    @AppStorage("editType") var editType: Behavior = .inlineEdit
    @FocusState var isFocused: Bool
    @ObservedObject var viewModel: HistoryModel

    func onMySubmit(input: String) {
        switch input {
        case _ where [#"\:"#, #"\h"#, #"\'"#, #"\`"#, #"\+"#, #"\\:"#].contains(input):
            showHelp = true
        case "clear":
            viewModel.clear(b: curBuffer)
            self.input = ""
        case _ where input.hasPrefix(#"\,"#):
            let components = input.components(separatedBy: " ")
            if let lastWord = components.last {
                curBuffer = lastWord
            }
        default:
            if !input.isEmpty {
                // FIXME, below is a hacky workaround for appstorage not syncing?
                let output = UserDefaults.standard.integer(forKey: "lang") == Language.bqn.rawValue
                    ? e(input: input)
                    : ke(input: input)
                let attributeSet = CSSearchableItemAttributeSet(contentType: .plainText)
                attributeSet.title = input
                attributeSet.contentDescription = output
                let uniqueIdentifier = UUID().uuidString
                let searchableItem = CSSearchableItem(uniqueIdentifier: uniqueIdentifier, domainIdentifier: "arrscience.Beacons", attributeSet: attributeSet)
                CSSearchableIndex.default().indexSearchableItems([searchableItem]) { error in
                    if let error = error {
                        print("Indexing error: \(error.localizedDescription)")
                    } else {
                        print("Search item successfully indexed!")
                    }
                }
                viewModel.addMessage(with: input, out: output, lang: lang, for: curBuffer)
            } else {
                isFocused = false
            }
            self.input = ""
        }
    }

    var body: some View {
        ScrollViewReader { scrollView in
            VStack {
                ScrollView(.vertical) {
                    VStack {
                        if viewModel.history[curBuffer, default: []].isEmpty {
                            VStack {
                                Text("ngn/k, (c) 2019-2023")
                                    .font(Font.custom("BQN386 Unicode", size: 16))
                                    .foregroundColor(.primary)
                                Text("dzaima/cbqn, (c) 2019-2023")
                                    .font(Font.custom("BQN386 Unicode", size: 16))
                                    .foregroundColor(.primary)
                            }
                        } else {
                            ForEach(Array(viewModel.history[curBuffer, default: []].enumerated()), id: \.offset) { index, historyItem in
                                HistoryView(index: index, historyItem: historyItem, curBuffer: curBuffer, onMySubmit: onMySubmit, input: $input, ephemerals: $ephemerals, editType: $editType, viewModel: viewModel)
                            }.listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }
                    }.id("HistoryScrollView")
                        .onChange(of: viewModel.history) {
                            withAnimation {
                                scrollView.scrollTo("HistoryScrollView", anchor: .bottom)
                            }
                        }
                }
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .padding(.bottom, 5)

            ReplInput(text: $input,
                      helpOpen: $showHelp,
                      settingsOpen: $showSettings,
                      buffersOpen: $showBuffers,
                      lang: self.lang, onSubmit: { onMySubmit(input: self.input) },
                      font: Font.custom("BQN386 Unicode", size: 20))
                .padding(.bottom, 4)
                .focused($isFocused)
                .onTapGesture {
                    scrollView.scrollTo("HistoryScrollView", anchor: .bottom)
                }
                .onReceive(Just(input)) { newV in
                    if lang == .bqn {
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
                }
        }
        .padding(.top, 0.1)
        .sheet(isPresented: $showSettings) {
            ConfigView()
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showHelp) {
            HelpView(key: self.$input)
                .presentationDetents([.large])
        }
        .sheet(isPresented: $showBuffers) {
            BuffersView(buffers: $viewModel.history, sel: self.$curBuffer)
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
        // isFocused = true
    }
}

/*
 struct ContentView_Preview: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */
