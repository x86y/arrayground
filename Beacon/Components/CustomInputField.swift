//
//  CustomInputField.swift
//  Beacon
//
//
//

/* FOR BQN
 .toolbar {
 ToolbarItemGroup(placement: .keyboard) {
 ScrollView(.horizontal) {
 HStack {
 ForEach(glyphs, id: \.self) { glyph in
 Button(glyph) {
 print(glyph)
 }
 .font(Font.custom("BQN386 Unicode", size: 30))
 }
 }
 }
 }
 }
 */

import SwiftUI
import UIKit

struct CustomInputField: UIViewRepresentable {
    @Binding var text: String
    @Binding var settingsOpen: Bool
    @Binding var buffersOpen: Bool
    var onSubmit: (() -> Void)?
    var font: UIFont
    var keyboardType: UIKeyboardType

    init(text: Binding<String>, settingsB: Binding<Bool>, buffersB: Binding<Bool>, onSubmit: (() -> Void)? = nil, font: UIFont, keyboardType: UIKeyboardType) {
        _text = text
        _settingsOpen = settingsB
        _buffersOpen = buffersB
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

        let buttonOne = createCustomButton(image: true, title: "arrow.left.square.fill", action: #selector(Coordinator.btnBuffers), coordinator: context.coordinator)
        let buttonTwo = createCustomButton(image: true, title: "arrow.right.square.fill", action: #selector(Coordinator.btnSettings), coordinator: context.coordinator)
        let buttonThree = createCustomButton(image: true, title: "list.bullet.rectangle.portrait.fill", action: #selector(Coordinator.btnBuffers), coordinator: context.coordinator)
        let buttonFour = createCustomButton(image: true, title: "command.square.fill", action: #selector(Coordinator.btnSettings), coordinator: context.coordinator)
        stickyRightView.addArrangedSubview(buttonOne)
        stickyRightView.addArrangedSubview(buttonTwo)
        stickyRightView.addArrangedSubview(buttonThree)
        stickyRightView.addArrangedSubview(buttonFour)

        let scrollable = UIStackView()
        scrollable.axis = .horizontal
        scrollable.distribution = .fillEqually
        scrollable.spacing = 8
        let letters = ["'", "/", "\\", "%", "*", "+", "-", "\"", ":"]
        for (_, letter) in letters.enumerated() {
            let button = createCustomButton(image: false, title: letter, action: #selector(Coordinator.letterTap(_:)), coordinator: context.coordinator)
            scrollable.addArrangedSubview(button)
        }
        let scrollView = UIScrollView()
        scrollView.addSubview(scrollable)
        scrollable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollable.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollable.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollable.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollable.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollable.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textView.frame.size.width, height: 44))
        let sticky = UIBarButtonItem(customView: stickyRightView)
        let iscrollable = UIBarButtonItem(customView: scrollView)
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)

        toolbar.items = [iscrollable, sticky]
        textView.inputAccessoryView = toolbar
        return textView
    }


    func createCustomButton(image: Bool, title: String, action: Selector, coordinator: Coordinator) -> UIButton {
        let button = UIButton()
        if image {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
            if let image = UIImage(systemName: title, withConfiguration: symbolConfiguration) {
                button.setImage(image, for: .normal)
                button.tintColor = UIColor.label
            }
        } else {
            button.setTitle(title, for: .normal)
        }
        button.addTarget(coordinator, action: action, for: .touchUpInside)
        button.backgroundColor = UIColor(Color.gray.opacity(0.1))
        button.layer.cornerRadius = 8
        button.tag = title.hashValue
        button.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
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


#Preview {
    // CustomInputField()
}
