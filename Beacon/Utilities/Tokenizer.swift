//
//  Tokenizer.swift
//  Arrayground
//

import Foundation
import SwiftUI

func tokenToColor(_ type: TokenType) -> Color {
    switch type {
    case .regC:
        return Color.gray // '#D2D2D2'
    case .fnsC:
        return Color.green // '#32E732'
    case .mopC:
        return Color.yellow // '#FFF455'
    case .namC:
        return Color.white // '#D2D2D2'
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

enum TokenType: String {
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

struct Token: Identifiable {
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
