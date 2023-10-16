//
//  CustomInputField.swift
//

import SwiftUI
import UIKit

class NewlineTextView: UITextView {
    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: "\r", modifierFlags: [.shift], action: #selector(shiftEnterPressed)),
        ]
    }

    @objc func shiftEnterPressed() {
        let cursorPosition = selectedRange
        text.insert("\n", at: text.index(text.startIndex, offsetBy: cursorPosition.location))
        selectedRange = NSRange(location: cursorPosition.location + 1, length: 0)
    }
}

struct CustomInputField: UIViewRepresentable {
    @Binding var text: String
    @Binding var helpOpen: Bool
    @Binding var settingsOpen: Bool
    @Binding var buffersOpen: Bool
    var lang: Language
    var onSubmit: (() -> Void)?
    var font: UIFont
    var keyboardType: UIKeyboardType

    init(text: Binding<String>, helpB: Binding<Bool>, settingsB: Binding<Bool>, buffersB: Binding<Bool>, onSubmit: (() -> Void)? = nil, font: UIFont, keyboardType: UIKeyboardType, lang: Language) {
        _text = text
        _settingsOpen = settingsB
        _buffersOpen = buffersB
        _helpOpen = helpB
        self.onSubmit = onSubmit
        self.font = font
        self.keyboardType = keyboardType
        self.lang = lang
    }

    func updateLetterButtons(coordinator: Coordinator, scrollable: UIStackView) {
        // clear the existing buttons
        scrollable.arrangedSubviews.forEach { $0.removeFromSuperview() }

        var letters = ["'", "/", "\\", "%", "*", "+", "-", "=", "!", "\"", ":"]
        if lang == .bqn {
            letters = glyphs // Assuming `glyphs` is defined elsewhere
        }

        // recreate the buttons
        for (_, letter) in letters.enumerated() {
            let button = createBtn(image: false, title: letter, action: #selector(Coordinator.letterTap(_:)), coordinator: coordinator)
            scrollable.addArrangedSubview(button)
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        textView.invalidateIntrinsicContentSize()
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = NewlineTextView()
        textView.delegate = context.coordinator
        textView.font = font
        textView.keyboardType = keyboardType
        textView.returnKeyType = .done
        textView.autocorrectionType = .no
        textView.becomeFirstResponder()
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 16
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        textView.sizeToFit()

        let stickyRightView = UIStackView()
        stickyRightView.axis = .horizontal
        stickyRightView.distribution = .fillEqually
        stickyRightView.spacing = 10

        let buttonOne = createBtn(image: true, title: "arrow.left.square.fill", action: #selector(Coordinator.btnClearnInp), coordinator: context.coordinator)
        let buttonTwo = createBtn(image: true, title: "questionmark.app.fill", action: #selector(Coordinator.btnHelp), coordinator: context.coordinator)
        let buttonThree = createBtn(image: true, title: "list.bullet.rectangle.portrait.fill", action: #selector(Coordinator.btnBuffers), coordinator: context.coordinator)
        let buttonFour = createBtn(image: true, title: "command.square.fill", action: #selector(Coordinator.btnSettings), coordinator: context.coordinator)
        stickyRightView.addArrangedSubview(buttonOne)
        stickyRightView.addArrangedSubview(buttonTwo)
        stickyRightView.addArrangedSubview(buttonThree)
        stickyRightView.addArrangedSubview(buttonFour)

        let scrollable = UIStackView()
        scrollable.axis = .horizontal
        scrollable.distribution = .fillEqually
        scrollable.spacing = 8
        updateLetterButtons(coordinator: context.coordinator, scrollable: scrollable)
        let scrollView = UIScrollView()
        scrollView.addSubview(scrollable)
        scrollable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollable.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollable.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollable.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollable.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollable.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textView.frame.size.width, height: 44))
        let sticky = UIBarButtonItem(customView: stickyRightView)
        let iscrollable = UIBarButtonItem(customView: scrollView)

        toolbar.items = [iscrollable, sticky]
        textView.inputAccessoryView = toolbar
        return textView
    }

    func createBtn(image: Bool, title: String, action: Selector, coordinator: Coordinator) -> UIButton {
        let button = UIButton()
        if image {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
            if let image = UIImage(systemName: title, withConfiguration: symbolConfiguration) {
                button.setImage(image, for: .normal)
            }
        } else {
            button.setTitle(title, for: .normal)
        }
        button.addTarget(coordinator, action: action, for: .touchUpInside)
        button.backgroundColor = UIColor(Color.gray.opacity(0.1))
        button.layer.cornerRadius = 8
        button.tag = title.hashValue
        button.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        return button
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

        @objc func onSubmit() {
            parent.onSubmit?()
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }

        func textView(_: UITextView, shouldChangeTextIn _: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                parent.onSubmit?()
                return false
            }
            return true
        }

        @objc func btnClearnInp() {
            parent.text = ""
        }

        @objc func btnHelp() {
            parent.helpOpen = true
        }

        @objc func btnBuffers() {
            parent.buffersOpen = true
        }

        @objc func btnSettings() {
            parent.settingsOpen = true
        }

        @objc func letterTap(_ sender: UIButton) {
            if let letter = sender.titleLabel?.text {
                if letter == "\"" && parent.text == "" {
                    parent.text.append(letter)
                    parent.text.append(letter)
                } else {
                    parent.text.append(letter)
                }
            }
        }
    }
}

// #Preview {
// CustomInputField()
// }
