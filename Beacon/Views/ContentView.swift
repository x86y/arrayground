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

    func onMySubmit(input: String) async {
        switch input {
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
                let key = UUID()
                Task {
                    let output = await UserDefaults.standard.integer(forKey: "lang") == Language.bqn.rawValue
                        ? e(input: input)
                        : ke(input: input)
                    
                    let attr = CSSearchableItemAttributeSet(contentType: .item)
                    attr.title = input
                    attr.contentDescription = output
                    attr.displayName = input
                    let uid = UUID().uuidString
                    let item = CSSearchableItem(uniqueIdentifier: uid, domainIdentifier: "arrscience.beacons", attributeSet: attr)
                    try await CSSearchableIndex.default().indexSearchableItems([item])

                    viewModel.addMessage(id: key, with: input, out: output, lang: lang, for: curBuffer, isLoading: false)
                }
                viewModel.addMessage(id: key, with: input, out: "", lang: lang, for: curBuffer, isLoading: true)

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
                    VStack(spacing: 12) {
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
                      lang: self.lang, onSubmit: { Task { await onMySubmit(input: self.input) } },
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
            HelpView()
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
        // below is adapted from https://codeberg.org/ngn/k/src/branch/master/repl.k
        let k_formatter = """
(opn;sem;cls):"(;)"
lines:cols:80
upd:(lines;cols)
lim:{(x<#y)(x#)/y}
dd:{(x<#y)(,[;".."](x-2)#)/y}
fmt:{upd[];$[(::)~x;"";(1<#x)&|/`m`M`A=@x;mMA x;(dd[cols]`k@lim[cols]x),"\n"]}
fmtx:{$[(::)~x;"";`k[x],"\n"]}
mMA:{(P;f;q):((,"!/+(";dct;,")");(("+![";" +(");tbl;")]");(,,"(";lst;,")"))`m`M`A?t:@x
 w:cols-#*P;u:w-#q;h:lines-2
 x:$[h<(`M=t)+#x;,[;,".."](h-1)#f[w;u;h#x];f[w;u;x]]
 ,[;"\n"]@"\n"/@[;-1+#x;,;q]P[!#x],'x}
lst:{[w;u;x](((-1+#x)#w),u)dd'`k'lim[cols]'x}
dct:{[w;u;x]k:(|/#'k)$k:`k'!x;par'(((-1+#x)#w-3),u-3)dd'sem/'+(k;`k'.x)}
tbl:{[w;u;x]h:`k'!x;d:`k''.x;W:(#'h)|/'#''d
 r:,$[`S~@!x;dd[w](""opn),(""sem)/;par@dd[w-2]@sem/]W$'h
 r,par'dd[w-2]'sem/'+@[W;&~^`i`d?_@'.x;-:]$'}
cell:{$[|/`i`d=@y;-x;x]$z}
par:{opn,x,cls}
line0:{c:{0x07~*-2#*x}{(l;r):x;(1:1;r,,(-2_l))}/(x;());"\n"/(*|c),,*c}
line1:{$[#x;;:0];.[`1:(fmt;fmtx)[" "~*x]@.:;,x;{`0:`err[]}]}
line:line1@line0@
"""
        let _ = runCmd(kCmd, k_formatter)
    }
}
