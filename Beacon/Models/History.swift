//
//  History.swift
//  Arrayground
//

import Foundation

let d = UserDefaults.standard

struct Entry: Hashable, Codable, Identifiable {
    var id: String = UUID().uuidString
    var src: String
    var out: String
}

enum Buffers {
    static let k = "history"
    static func save(_ value: [String: [Entry]]) {
        d.set(try? PropertyListEncoder().encode(value), forKey: k)
    }

    static func get() -> [String: [Entry]] {
        guard let data = d.object(forKey: k) as? Data else { return ["default": []] }
        do {
            let userData = try PropertyListDecoder().decode([String: [Entry]].self, from: data)
            return userData
        } catch {
            print("Error decoding the history: \(error)")
            return ["default": []]
        }
    }

    static func clear() {
        d.removeObject(forKey: k)
    }
}

class HistoryModel: ObservableObject {
    @Published var history: [String: [Entry]] = ["default": []]

    func addMessage(with src: String, out: String, for key: String) {
        let entry = Entry(src: src, out: out)
        if var entries = history[key] {
            entries.append(entry)
            history[key] = entries
        } else {
            history[key] = [entry]
        }
        Buffers.save(history)
    }

    func load(_ h: [String: [Entry]]) {
        history = h
    }

    func clear(b: String) {
        history[b] = []
        Buffers.clear()
    }
}
