//
//  KeyboardViewController.swift
//

import KeyboardKit
import SwiftUI

class KeyboardViewController: KbViewController {
    override func viewDidLoad() {
        inputSetProvider = BQNSP()
        super.viewDidLoad()
    }
}
