//
//  KeyboardView.swift
//  KeyboardKitDemo
//

import KeyboardKit
import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext
    unowned var controller: KeyboardInputViewController
    @EnvironmentObject
    private var keyboardContext: KeyboardContext
    @EnvironmentObject
    private var keyboardTextContext: KeyboardTextContext

    var body: some View {
        VStack(spacing: 0) {
            if keyboardContext.keyboardType != .emojis {
                autocompleteToolbar
            }
            SystemKeyboard(
                controller: controller,
                autocompleteToolbar: .none
            )
        }
    }
}

// MARK: - Private Views

private extension KeyboardView {
    var autocompleteToolbar: some View {
        AutocompleteToolbar(
            suggestions: autocompleteContext.suggestions,
            locale: keyboardContext.locale,
            suggestionAction: controller.insertAutocompleteSuggestion
        ).font(Font.custom("BQN386 Unicode", size: 24)).opacity(keyboardContext.prefersAutocomplete ? 1 : 0) // Still allocate height
    }
}
