//
//  BufferView.swift
//  Beacon
//

import SwiftUI

struct BuffersView: View {
    @Binding var buffers: [String: [Entry]]
    @Binding var sel: String

    var body: some View {
        Section {
            Text("Buffers")
                .font(.system(.body, design: .monospaced, weight: .semibold))
                .padding()

            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    ForEach(Array(buffers.keys), id: \.self) { b in
                        Button(action: {
                            self.sel = b
                        }) {
                            HStack {
                                Text(b)
                                    .font(.system(.body, design: .monospaced))
                                    .padding()
                                    .background(self.sel == b ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1)) // Change colour if selected
                                    .cornerRadius(8)
                                Spacer()
                                Button(action: {
                                    buffers[b] = nil
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                                .padding(.trailing)
                            }
                        }
                    }
                }.padding(.horizontal)
                HStack {
                    Spacer()
                    Button(action: {
                        sel = genRandBuffer(length: 8)
                        buffers[sel] = []
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 36)) // Increase the size here
                    }
                    .padding(.trailing)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    // BuffersView(buffers:  ["key1": "value1", "key2": "value2"], sel: .constant("1"))
}
