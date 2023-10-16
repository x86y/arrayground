//
//  KbViewController.swift
//  KeyboardKit
//

import KeyboardKit
import SwiftUI

class KbViewController: KeyboardInputViewController {
    override func viewDidLoad() {
        keyboardContext.setLocale(.english)
        keyboardContext.keyboardDictationReplacement = .keyboardType(.emojis)
        autocompleteProvider = FakeAutocompleteProvider()
        keyboardStyleProvider = DemoKeyboardAppearance(keyboardContext: keyboardContext)
        keyboardActionHandler = DemoKeyboardActionHandler(inputViewController: self)
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider
        )
        super.viewDidLoad()
    }

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { KeyboardView(controller: $0) }
    }
}
