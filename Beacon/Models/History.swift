//
//  History.swift
//  Arrayground
//

import Foundation

let d = UserDefaults.standard

struct Entry: Hashable, Codable, Identifiable {
    var id: UUID
    var src: String
    var out: String
    var lang: Language
    var tokens: [[Token]]
    var isLoading: Bool
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

    func addMessage(id: UUID, with src: String, out: String, lang: Language, for key: String, isLoading: Bool) {
        if !isLoading {
            if let index = history[key]?.firstIndex(where: { $0.id == id }) {
                history[key]?.remove(at: index)
            }
        }
        let tokenize = lang == .k
            ? tokenize(src, lexK(src))
            : tokenize(src, lexBQN(src))
        let entry = Entry(id: id, src: src, out: out, lang: lang, tokens: tokenize, isLoading: isLoading)
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
