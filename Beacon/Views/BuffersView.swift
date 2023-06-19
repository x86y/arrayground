//
//  BufferView.swift
//  Beacon
//

import SwiftUI

struct BuffersView: View {
    var buffers: [String]
    @Binding var sel: String

    var body: some View {
        Section {
            Text("Buffers")
                .font(.system(.body, design: .monospaced, weight: .semibold))
                .padding()

            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    ForEach(Array(buffers), id: \.self) { b in
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
                                    //wip
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                                .padding(.trailing)
                            }
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }
}


#Preview {
    BuffersView(buffers: ["1", "2"], sel: .constant("1"))
}
