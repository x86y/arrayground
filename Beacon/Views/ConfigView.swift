//
//  ConfigView.swift
//  Arrayground
//

import SwiftUI

enum Appearance: Int {
    case system = 0
    case light = 1
    case dark = 2
}

enum AppFont: Int {
    case bqn386 = 0
    case iosevka = 1
    case apl = 2
}

enum Language: Int, Codable {
    case bqn = 0
    case k = 1
}

func languageToString(l: Language) -> String {
    if l == .bqn {
        return "BQN"
    } else {
        return "K"
    }
}

enum Behavior: Int {
    case inlineEdit = 0
    case duplicate = 1
}

struct ConfigView: View {
    @AppStorage("scheme") private var scheme: Appearance = .system
    @AppStorage("font") private var font: AppFont = .bqn386
    @AppStorage("lang") private var lang: Language = .k
    @AppStorage("editType") private var editType: Behavior = .duplicate

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        HStack {
                            Text("Language")
                            Picker(selection: $lang) {
                                Text("BQN")
                                    .tag(Language.bqn)
                                Text("K")
                                    .tag(Language.k)
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
                            Text("Input Click Behavior")
                            Picker(selection: $editType) {
                                Text("Inline edit")
                                    .tag(Behavior.inlineEdit)
                                Text("Duplicate")
                                    .tag(Behavior.duplicate)
                            } label: {
                                Text("")
                            }
                            .pickerStyle(.menu)
                        }
                    } header: {
                        Text("App Behavior")
                    }.headerProminence(.increased)
                    Section {
                        HStack {
                            Text("Colorscheme")
                            Picker(selection: $scheme) {
                                Text("System")
                                    .tag(Appearance.system)
                                Text("Light")
                                    .tag(Appearance.light)
                                Text("Dark")
                                    .tag(Appearance.dark)
                            } label: {
                                Text("")
                            }
                        }
                        .pickerStyle(.menu)
                        HStack {
                            Text("Font")
                            Picker(selection: $font) {
                                Text("BQN386")
                                    .tag(AppFont.bqn386)
                                Text("Iosevka")
                                    .tag(AppFont.iosevka)
                                Text("APL")
                                    .tag(AppFont.apl)
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
