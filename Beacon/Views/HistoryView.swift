//
//  HistoryView.swift
//  Arrayground
//

import Foundation
import SwiftUI

struct HistoryView: View {
    var index: Int
    var historyItem: Entry
    var curBuffer: String
    var onMySubmit: (String) async -> Void
    @Binding var input: String
    @Binding var ephemerals: [Int: [String]]
    @Binding var editType: Behavior
    @ObservedObject var viewModel: HistoryModel
    @Environment(\.colorScheme) var scheme: ColorScheme
    @State private var isShowingCard = false
    
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
                    Task {
                        let src = self.viewModel.history[curBuffer, default: []][index].src
                        await onMySubmit(src)
                        for k in ephemerals.keys {
                            self.viewModel.history[curBuffer, default: []][k].src = ephemerals[k, default: []].first!
                        }
                        ephemerals = [:] // reset all virtual textfield edits
                    }
                }
                .font(Font.custom("BQN386 Unicode", size: 18))
                .foregroundColor(.blue)
            } else if editType == Behavior.duplicate {
                VStack(spacing: 1) {
                    ForEach(Array(historyItem.tokens.enumerated()), id: \.offset) { _, line in
                        HStack(spacing: 0) {
                            ForEach(line, id: \.id) { token in
                                let isDarkTheme = (scheme == .dark)
                                let col = historyItem.lang == Language.k ? colorK(token.type, isDarkTheme) : colorBQN(token.type)
                                Text(token.value)
                                    .lineLimit(1) // HACK to stop long tokens from messing alignment
                                    .foregroundColor(col)
                                    .font(Font.custom("BQN386 Unicode", size: 18))
                                    .onTapGesture {
                                        self.input = historyItem.src
                                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                                    }
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .onLongPressGesture(minimumDuration: 0.5) {
                                withAnimation {
                                    self.isShowingCard = true
                                }
                            }
                    }
                }
                .popover(isPresented: $isShowingCard) {
                    Text("selectedLine")
                        .padding()
                        .frame(width: 200, height: 100)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
            }
            if historyItem.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(0.5, anchor: .center)
            } else {
                Text("\(trimLongText(historyItem.out))")
                    .foregroundStyle(.primary.opacity(0.8))
                    .font(Font.custom("BQN386 Unicode", size: 18))
                    .foregroundColor(historyItem.out.starts(with: "Error:") || historyItem.out.starts(with: "\"Error:") ? .red : .primary)
                    .multilineTextAlignment(.leading)
                    .onTapGesture {
                        self.input = historyItem.out
                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                    }
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}
