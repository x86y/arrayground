//
//  DemoKeyboardAppearance.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-10-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This demo-specific appearance inherits the standard one and
 can be used to customize the demo keyboard.

 ``KeyboardViewController`` registers it to show how you can
 register and use a custom keyboard appearance.

 Just comment out any of the functions below to override any
 part of the standard appearance.
 */
class DemoKeyboardAppearance: StandardKeyboardAppearance {
    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardButtonStyle {
        var style = super.buttonStyle(for: action, isPressed: isPressed)
        //style.cornerRadius = 10
        //style.backgroundColor = .blue
        //style.foregroundColor = .yellow
        if action != KeyboardAction.space && action != KeyboardAction.backspace && action != KeyboardAction.primary(.return) {
            style.font = KeyboardFont.custom("BQN386 Unicode", size: 24)
        }
        return style
    }

    override var inputCalloutStyle: KeyboardInputCalloutStyle {
         var style = super.inputCalloutStyle
         style.font = KeyboardFont.custom("BQN386 Unicode", size: 24)
         return style
     }
}
