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

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = font
        textView.keyboardType = keyboardType
        textView.returnKeyType = .done
        textView.autocorrectionType = .no
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = true
        textView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        textView.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        textView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 500), for: NSLayoutConstraint.Axis.vertical)

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

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text

        if let toolbar = uiView.inputAccessoryView as? UIToolbar,
           let scrollView = toolbar.items?.first?.customView as? UIScrollView,
           let scrollable = scrollView.subviews.first as? UIStackView
        {
            updateLetterButtons(coordinator: context.coordinator, scrollable: scrollable)
        }
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
