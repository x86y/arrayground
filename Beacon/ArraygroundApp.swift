//
//  ArraygroundApp.swift
//  Arrayground
//

import SwiftUI

@main
struct ArraygroundApp: App {
    @AppStorage("scheme") private var scheme: Appearance = .system
    @State private var selectedView = 0
    var appearanceSwitch: ColorScheme? {
        if scheme == .light {
            return .light
        } else if scheme == .dark {
            return .dark
        } else {
            return .none
        }
    }

    @StateObject private var viewModel = HistoryModel()

    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedView) {
                ContentView(viewModel: viewModel).tag(0)
                    .preferredColorScheme(appearanceSwitch)
                // Dashboard().tag(1)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: selectedView) {
                    dismissKeyboard()
                }
        }
    }

    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
