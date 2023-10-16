//
//  KeyboardAppearance.swift
//  Keyboard
//
//

import KeyboardKit
import SwiftUI

class DemoKeyboardAppearance: StandardKeyboardStyleProvider {
    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardStyle.Button {
        var style = super.buttonStyle(for: action, isPressed: isPressed)
        // style.cornerRadius = 10
        // style.backgroundColor = .blue
        // style.foregroundColor = .yellow
        if action != KeyboardAction.space && action != KeyboardAction.backspace && action != KeyboardAction.primary(.return) {
            style.font = KeyboardFont.custom("BQN386 Unicode", size: 24)
        }
        return style
    }

    override var inputCalloutStyle: KeyboardStyle.InputCallout {
        var style = super.inputCalloutStyle
        style.font = KeyboardFont.custom("BQN386 Unicode", size: 24)
        return style
    }
}
