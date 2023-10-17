//
//  LexK.swift
//  Arrayground
//

import Foundation
import SwiftUI

func parseK(_ str: String) -> [String] {
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
