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
    @AppStorage("ephBehavior") private var ephBehavior: Int = 0
    @FocusState var isFocused: Bool
    @ObservedObject var viewModel = HistoryModel()
    
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
                if chosenLang == 0 {
                    viewModel.addMessage(with: input, out: e(input: input), for: curBuffer)
                } else {
                    viewModel.addMessage(with: input, out: ke(input: input), for: curBuffer)
                }
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
                        ForEach(Array(viewModel.history[curBuffer, default: []].enumerated()), id: \.offset) { index, h in
                            VStack(alignment: .leading) {
                                if ephBehavior == 0 {
                                    TextField("Source", text: Binding(
                                        get: {
                                            if index < viewModel.history[curBuffer, default: []].count {
                                                return self.viewModel.history[curBuffer, default: []][index].src
                                            } else {
                                                return ""
                                            }},
                                        set: {
                                            if index < viewModel.history[curBuffer, default: []].count {
                                                self.viewModel.history[curBuffer, default: []][index].src = $0
                                                ephemerals[index, default: []].append($0)
                                            }
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
                                } else if ephBehavior == 1 {
                                    Text(h.src)
                                        .font(Font.custom("BQN386 Unicode", size: 18))
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            self.input = h.src
                                        }
                                }
                                Text("\(trimLongText(h.out))")
                                    .font(Font.custom("BQN386 Unicode", size: 18))
                                    .foregroundColor(h.out.starts(with: "Error:") ? .red : .primary)
                                    .multilineTextAlignment(.leading)
                                    .onTapGesture {
                                        self.input = h.out
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
                .padding(.bottom, 5)
            
            CustomInputField(text: $input,
                             helpB: $showHelp,
                             settingsB: $showSettings,
                             buffersB: $showBuffers,
                             onSubmit: { onMySubmit(input: self.input) },
                             font: UIFont(name: "BQN386 Unicode", size: 20)!,
                             keyboardType: .asciiCapable)
            .frame(height: 24)
            .padding(.bottom, 4)
            .focused($isFocused)
            .onTapGesture {
                //isFocused = true
                scrollView.scrollTo("HistoryScrollView", anchor: .bottom)
            }
            .onReceive(Just(input)) { newV in
                if chosenLang == 0 {
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
            BuffersView(buffers: Array(viewModel.history.keys), sel: self.$curBuffer)
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
        //isFocused = true
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
