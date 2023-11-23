//
//  Lexer.swift
//  Arrayground
//
//  Lexing adapted from https://github.com/dzaima/paste

import Foundation
import SwiftUI

func lexK(_ str: String) -> [String] {
    let regC = "0"
    let fnsC = "1"
    let fns = "+-*%!&|<>=~,^#_?@."
    let mopC = "2"
    let mop = "/'\\"
    let namC = "4"
    let nam = "⎕⍞∆⍙ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    let digC = "5"
    let dig = "0123456789¯∞"
    let parC = "6"
    let dfnC = "7"
    let strC = "8"
    let dmdC = "D"
    let dmd = ":$"
    let comC = "C"
    let endL = "E"

    var res = Array(repeating: "", count: str.count)
    res[0] = regC

    var i = 0
    while i < str.count {
        let p = charAt(str, i - 1)
        let c = charAt(str, i)
        let n = charAt(str, i + 1)

        if dig.contains(c) || (c == "." && dig.contains(n)) {
            res[i] = digC
            while i < str.count, dig.contains(charAt(str, i)) || ".eEnNbiwW".contains(charAt(str, i)) {
                i += 1
            }
            continue
        } else if (c == " " && n == "/") || ((p == "\n" || p == "\0") && c == "/") {
            res[i] = comC
            while i < str.count, charAt(str, i) != "\n" {
                i += 1
            }
            if charAt(str, i) == "\n" { res[i] = endL }
        } else if fns.contains(c) || c.unicodeScalars.first!.value >= 0x80 {
            res[i] = fnsC
        } else if mop.contains(c) {
            res[i] = mopC
            if n == ":" {
                i += 1
                res[i] = mopC
            }
        } else if "{xyz}".contains(c) {
            res[i] = dfnC
        } else if "([])".contains(c) {
            res[i] = parC
        } else if dmd.contains(c) {
            res[i] = dmdC
        } else if nam.contains(c) {
            res[i] = namC
            while i < str.count, nam.contains(charAt(str, i)) || dig.contains(charAt(str, i)) {
                i += 1
            }
            continue
        } else if c == "\"" {
            res[i] = strC
            i += 1
            while charAt(str, i) != "\"", charAt(str, i) != "\n" {
                i += charAt(str, i) == "\\" ? 2 : 1
            }
        } else if !" \t".contains(c) {
            res[i] = regC
        }
        i += 1
    }

    return res
}

func charAt(_ str: String, _ i: Int) -> String {
    if i < 0 || i >= str.count {
        return "\0"
    }
    let index = str.index(str.startIndex, offsetBy: i)
    return String(str[index])
}

func lexBQN(_ code: String) -> [String] {
    let regC = "0"
    let fnsC = "1"
    let fns = "!+-×÷⋆*√⌊⌈∧∨¬|=≠≤<>≥≡≢⊣⊢⥊∾≍⋈↑↓↕⌽⍉/⍋⍒⊏⊑⊐⊒∊⍷⊔«»⍎⍕"
    let mopC = "2"
    let mop = "`˜˘¨⁼⌜´˝˙"
    let dopC = "3"
    let dop = "∘⊸⟜○⌾⎉⚇⍟⊘◶⎊"
    let namC = "4"
    let nam = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_"
    let digC = "5"
    let dig = "0123456789π∞"
    let digS = dig + "¯."
    let digM = "eEiI"
    let arrC = "6"
    let arr = "·⍬‿⦃⦄⟨⟩[]@"
    let dfnC = "7"
    let dfn = "𝕨𝕩𝔽𝔾𝕎𝕏𝕗𝕘𝕣ℝ𝕤𝕊{}:"
    let strC = "8"
    let dmdC = "D"
    let dmd = "←↩,⋄→⇐"
    let comC = "C"
    let _newL = "E"

    var res = Array(repeating: "", count: code.count)
    var i = code.startIndex

    while i < code.endIndex {
        let c = code[i]
        if digS.contains(c) {
            res[i.utf16Offset(in: code)] = digC
            i = code.index(after: i)
            while dig.contains(code[safe: i] ?? "\0") || code[safe: i] == "." || digM.contains(code[safe: i] ?? "\0") && digS.contains(code[safe: code.index(after: i)] ?? "\0") {
                i = code.index(after: i)
            }
            continue
        } else if fns.contains(c) {
            res[i.utf16Offset(in: code)] = fnsC
        } else if mop.contains(c) {
            res[i.utf16Offset(in: code)] = mopC
        } else if dop.contains(c) {
            res[i.utf16Offset(in: code)] = dopC
        } else if dfn.contains(c) {
            res[i.utf16Offset(in: code)] = dfnC
        } else if arr.contains(c) {
            res[i.utf16Offset(in: code)] = arrC
        } else if dmd.contains(c) {
            res[i.utf16Offset(in: code)] = dmdC
        } else if nam.contains(c) || c == "•" {
            let fst = i
            if code[safe: i] == "•" {
                i = code.index(after: i)
            }
            let cs = code[safe: i] ?? "\0"
            while nam.contains(code[safe: i] ?? "\0") || dig.contains(code[safe: i] ?? "\0") {
                i = code.index(after: i)
            }
            let ce = code[safe: code.index(before: i)] ?? "\0"
            let offset = fst.utf16Offset(in: code)
            if offset < res.count {
                res[offset] = cs == "_" ? (ce == "_" ? dopC : mopC) : (cs >= "A" && cs <= "Z" ? fnsC : namC)
            } else {
                // Handle this case
            }
            continue
        } else if c == "'" || c == "\"" {
            res[i.utf16Offset(in: code)] = strC
            i = code.index(after: i)
            let q = c
            while code[safe: i] != nil, code[safe: i] != q, code[safe: i] != "\n" {
                i = code.index(after: i)
            }
        } else if c == "#" {
            res[i.utf16Offset(in: code)] = comC
            while code[safe: i] != nil, code[safe: i] != "\n" {
                i = code.index(after: i)
            }
        } else if !" \n\t".contains(c) {
            res[i.utf16Offset(in: code)] = regC
        }
        i = code.index(after: i)
    }
    return res
}

extension String {
    subscript(safe index: Index) -> Character? {
        return indices.contains(index) ? self[index] : nil
    }
}
