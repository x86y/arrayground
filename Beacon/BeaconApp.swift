//
//  BeaconApp.swift
//  Beacon
//
//
//

import SwiftUI

@main
struct BeaconApp: App {
    @AppStorage("appearanceSelection") private var appearanceSelection: Int = 0
    var appearanceSwitch: ColorScheme? {
        if appearanceSelection == 1 {
            return .light
        } else if appearanceSelection == 2 {
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
