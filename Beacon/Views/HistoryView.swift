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
                .foregroundStyle(.primary.opacity(0.8))
                .font(Font.custom("BQN386 Unicode", size: 18))
                .foregroundColor(historyItem.out.starts(with: "Error:") || historyItem.out.starts(with: "\"Error:") ? .red : .primary)
                .multilineTextAlignment(.leading)
                .onTapGesture {
                    self.input = historyItem.out
                }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}
