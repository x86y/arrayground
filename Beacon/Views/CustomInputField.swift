//
//  CustomInputField.swift
//  Beacon
//
//  
//

import SwiftUI
import UIKit

struct CustomInputField: UIViewRepresentable {
    @Binding var text: String
    var onSubmit: (() -> Void)?
    var font: UIFont
    var keyboardType: UIKeyboardType

    init(text: Binding<String>, onSubmit: (() -> Void)? = nil, font: UIFont, keyboardType: UIKeyboardType) {
        _text = text
        self.onSubmit = onSubmit
        self.font = font
        self.keyboardType = keyboardType
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = font
        textView.keyboardType = keyboardType
        textView.returnKeyType = .done
        textView.autocorrectionType = .no
        return textView
    }

    func updateUIView(_ uiView: UITextView, context _: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomInputField

        init(_ textView: CustomInputField) {
            parent = textView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                // textView.resignFirstResponder()
                parent.onSubmit?()
                return false
            }
            if let currentText = textView.text,
               let range = Range(range, in: currentText)
            {
                let updatedText = currentText.replacingCharacters(in: range, with: text)
                parent.text = updatedText
            }
            return true
        }
    }
}

#Preview {
    // CustomInputField()
}
