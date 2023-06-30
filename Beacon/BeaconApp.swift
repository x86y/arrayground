//
//  BeaconApp.swift
//  Beacon
//

import SwiftUI

@main
struct BeaconApp: App {
    @AppStorage("scheme") private var scheme: Appearance = .system
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
            ContentView(viewModel: viewModel)
                .preferredColorScheme(appearanceSwitch)
        }
    }
}
