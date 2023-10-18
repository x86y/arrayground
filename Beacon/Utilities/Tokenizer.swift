//
//  Tokenizer.swift
//  Arrayground
//

import Foundation
import SwiftUI

func colorBQN(_ type: TokenType) -> Color {
    switch type {
    case .regC:
        return Color.gray // '#D2D2D2'
    case .fnsC:
        return Color.green // '#32E732'
    case .mopC:
        return Color.yellow // '#FFF455'
    case .namC:
        return Color.primary.opacity(0.8) // '#D2D2D2'
    case .digC:
        return Color.purple // '#FF80F4'
    case .parC:
        return Color.blue // '#89A7DC'
    case .dfnC:
        return Color.red // '#E3736D'
    case .strC:
        return Color.orange // '#DDAAEE'
    case .dmdC:
        return Color.yellow // '#FFFF00'
    case .comC:
        return Color.gray // '#898989'
    case .endL:
        return Color.gray // '#898989'
    }
}

func colorK(_ type: TokenType, _ isDarkTheme: Bool) -> Color {
    let colorHex: String
    switch type {
    case .regC, .namC:
        colorHex = isDarkTheme ? "39BAE6" : "000000"
    case .comC, .endL:
        colorHex = isDarkTheme ? "ACB6BF" : "6A737D"
    case .digC:
        colorHex = isDarkTheme ? "D2A6FF" : "005CC5"
    case .parC:
        colorHex = isDarkTheme ? "E6B673" : "000000"
    case .dmdC:
        colorHex = isDarkTheme ? "FFFF00" : "0000FF"
    case .strC:
        colorHex = isDarkTheme ? "AAD94C" : "032F62"
    case .fnsC:
        colorHex = isDarkTheme ? "F29668" : "D73A49"
    case .mopC:
        colorHex = isDarkTheme ? "39BAE6" : "ED5F00"
    case .dfnC:
        colorHex = isDarkTheme ? "FFB454" : "A906D4"
    }
    return Color(hex: colorHex)
}


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}


enum TokenType: String, Codable {
    case regC = "0"
    case fnsC = "1"
    case mopC = "2"
    case namC = "4"
    case digC = "5"
    case parC = "6"
    case dfnC = "7"
    case strC = "8"
    case dmdC = "D"
    case comC = "C"
    case endL = "E"
}

struct Token: Hashable, Codable, Identifiable {
    var id = UUID()
    let value: String
    let type: TokenType
}

func tokenize(_ str: String, _ lexed: [String]) -> [[Token]] {
    var tokens: [Token] = []
    var i = 0

    while i < lexed.count {
        if let type = TokenType(rawValue: lexed[i]) {
            var j = i + 1
            while j < lexed.count && lexed[j] == "" {
                j += 1
            }
            let value = str[str.index(str.startIndex, offsetBy: i) ..< str.index(str.startIndex, offsetBy: j)]
            tokens.append(Token(value: String(value), type: type))
            i = j
        } else {
            i += 1
        }
    }

    var res: [[Token]] = [[]]
    var temp: [Token] = []
    for token in tokens {
        if token.value == "\n" {
            if !temp.isEmpty {
                res.append(temp)
            }
            temp = []
        } else {
            temp.append(token)
        }
    }

    if !temp.isEmpty {
        res.append(temp)
    }

    return res
}
