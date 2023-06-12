//
//  BufferBrowserView.swift
//  Beacon
//

import SwiftUI

struct BufferBrowserView: View {
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
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                Spacer()
                            }
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }
}

#Preview {
    // BufferBrowserView()
}
