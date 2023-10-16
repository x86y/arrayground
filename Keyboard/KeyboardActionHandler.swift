//
//  KeyboardActionHandler.swift
//

import KeyboardKit
import UIKit

class DemoKeyboardActionHandler: StandardKeyboardActionHandler {
    // MARK: - Overrides

    override func action(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> KeyboardAction.GestureAction? {
        let standard = super.action(for: gesture, on: action)
        switch gesture {
        case .longPress: return longPressAction(for: action) ?? standard
        default: return standard
        }
    }

    // MARK: - Custom actions

    func longPressAction(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch action {
        case let .image(_, _, imageName): return { [weak self] _ in self?.saveImage(named: imageName) }
        default: return nil
        }
    }

    func tapAction(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch action {
        case let .image(_, _, imageName): return { [weak self] _ in self?.copyImage(named: imageName) }
        default: return nil
        }
    }

    // MARK: - Functions

    func alert(_: String) {
        print("Implement alert functionality if you want, or just place a breakpoint here.")
    }

    func copyImage(named imageName: String) {
        guard let image = UIImage(named: imageName) else { return }
        guard keyboardContext.hasFullAccess else { return alert("You must enable full access to copy images.") }
        guard image.copyToPasteboard() else { return alert("The image could not be copied.") }
        alert("Copied to pasteboard!")
    }

    func saveImage(named imageName: String) {
        guard let image = UIImage(named: imageName) else { return }
        guard keyboardContext.hasFullAccess else { return alert("You must enable full access to save images.") }
        image.saveToPhotos(completion: handleImageDidSave)
        alert("Saved to photos!")
    }
}

private extension DemoKeyboardActionHandler {
    func handleImageDidSave(withError error: Error?) {
        if error == nil { alert("Saved!") }
        else { alert("Failed!") }
    }
}

private extension UIImage {
    func copyToPasteboard(_ pasteboard: UIPasteboard = .general) -> Bool {
        guard let data = pngData() else { return false }
        pasteboard.setData(data, forPasteboardType: "public.png")
        return true
    }
}

private extension UIImage {
    func saveToPhotos(completion: @escaping (Error?) -> Void) {
        ImageService.default.saveImageToPhotos(self, completion: completion)
    }
}

private class ImageService: NSObject {
    public typealias Completion = (Error?) -> Void

    public private(set) static var `default` = ImageService()

    private var completions = [Completion]()

    public func saveImageToPhotos(_ image: UIImage, completion: @escaping (Error?) -> Void) {
        completions.append(completion)
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImageToPhotosDidComplete), nil)
    }

    @objc func saveImageToPhotosDidComplete(_: UIImage, error: NSError?, contextInfo _: UnsafeRawPointer) {
        guard completions.count > 0 else { return }
        completions.removeFirst()(error)
    }
}
