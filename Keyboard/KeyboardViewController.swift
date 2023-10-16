//
//  KeyboardViewController.swift
//

import KeyboardKit
import SwiftUI

class KeyboardViewController: KbViewController {
    override func viewDidLoad() {
        inputSetProvider = BQNSP()
        keyboardFeedbackSettings.enableHapticFeedback()
        super.viewDidLoad()
    }
}
