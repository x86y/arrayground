//
//  ConfigView.swift
//  Beacon
//
//
//

import SwiftUI

struct ConfigView: View {
    @AppStorage("appearanceSelection") private var appearanceSelection: Int = 0
    @AppStorage("fontSelection") private var fontSelection: Int = 0
    @AppStorage("langSelection") private var langSelection: Int = 0

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        HStack {
                            Text("Language")
                            Picker(selection: $langSelection) {
                                Text("BQN")
                                    .tag(0)
                                Text("K")
                                    .tag(1)
                            } label: {
                                Text("")
                            }
                            .pickerStyle(.menu)
                        }
                    } header: {
                        Text("Language Settings")
                    }.headerProminence(.increased)
                    Section {
                        HStack {
                            Text("Colorscheme")
                            Picker(selection: $appearanceSelection) {
                                Text("System")
                                    .tag(0)
                                Text("Light")
                                    .tag(1)
                                Text("Dark")
                                    .tag(2)
                            } label: {
                                Text("")
                            }
                        }
                        .pickerStyle(.menu)
                        HStack {
                            Text("Font")
                            Picker(selection: $fontSelection) {
                                Text("BQN386")
                                    .tag(0)
                                Text("Iosevka")
                                    .tag(1)
                                Text("APL")
                                    .tag(2)
                            } label: {
                                Text("")
                            }
                            .pickerStyle(.menu)
                        }
                    } header: {
                        Text("Appearances")
                    }.headerProminence(.increased)
                }
            }
        }
    }
}

#Preview {
    ConfigView()
}
