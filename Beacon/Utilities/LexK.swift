//
//  LexK.swift
//  Arrayground
//

import SwiftUI

enum TokenType {
    case number, function, variable, string, statement, comment, other
}

struct Token {
    let value: String
    let type: TokenType
}

func tokenize(code: String) -> [Token] {
    var tokens: [Token] = []
    var currentToken = ""
    var isComment = false
    var isString = false

    for char in code {
        if isComment {
            currentToken.append(char)
            if char == "\n" {
                tokens.append(Token(value: currentToken, type: .comment))
                currentToken = ""
                isComment = false
            }
            continue
        }

        if isString {
            currentToken.append(char)
            if char == "\"" {
                tokens.append(Token(value: currentToken, type: .string))
                currentToken = ""
                isString = false
            }
            continue
        }

        if char == "#" || char == "/" {
            isComment = true
            currentToken.append(char)
            continue
        }

        if char == "\"" {
            isString = true
            currentToken.append(char)
            continue
        }

        if char.isWhitespace {
            if !currentToken.isEmpty {
                tokens.append(Token(value: currentToken, type: determineType(token: currentToken)))
            }
            currentToken = ""
        } else {
            currentToken.append(char)
        }
    }

    if !currentToken.isEmpty {
        tokens.append(Token(value: currentToken, type: determineType(token: currentToken)))
    }

    return tokens
}

func determineType(token: String) -> TokenType {
    if Double(token) != nil {
        return .number
    }
    if token.last == ":" {
        return .function
    }
    if token.first?.isLetter == true {
        return .variable
    }
    if token == ":" {
        return .statement
    }
    return .other
}
