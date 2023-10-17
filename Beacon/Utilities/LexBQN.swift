//
//  LexBQN.swift
//  Beacon
//

import Foundation
import SwiftUI

func parseBQN(code: String) -> [String] {
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
    let newL = "E"

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
