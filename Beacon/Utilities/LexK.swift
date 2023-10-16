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
        let p = i - 1 >= 0 ? String(str[str.index(str.startIndex, offsetBy: i - 1) ... str.index(str.startIndex, offsetBy: i - 1)]) : "\0"
        let c = String(str[str.index(str.startIndex, offsetBy: i) ... str.index(str.startIndex, offsetBy: i)])
        let n = i + 1 < str.count ? String(str[str.index(str.startIndex, offsetBy: i + 1) ... str.index(str.startIndex, offsetBy: i + 1)]) : "\0"

        if dig.contains(c) || (c == "." && dig.contains(n)) {
            res[i] = digC
            while i < str.count, dig.contains(String(str[str.index(str.startIndex, offsetBy: i) ... str.index(str.startIndex, offsetBy: i)])) || ".eEnNbiwW".contains(String(str[str.index(str.startIndex, offsetBy: i) ... str.index(str.startIndex, offsetBy: i)])) {
                i += 1
            }

            continue
        } else if (c == " " && n == "/") || ((p == "\n" || p == "\0") && c == "/") {
            res[i] = comC
            while i < str.count, str[str.index(str.startIndex, offsetBy: i) ... str.index(str.startIndex, offsetBy: i)] != "\n" {
                i += 1
            }
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
            while nam.contains(String(str[str.index(str.startIndex, offsetBy: i) ... str.index(str.startIndex, offsetBy: i)])) || dig.contains(String(str[str.index(str.startIndex, offsetBy: i) ... str.index(str.startIndex, offsetBy: i)])) {
                i += 1
            }
            continue
        } else if c == "\"" {
            res[i] = strC
            i += 1
            while str[str.index(str.startIndex, offsetBy: i) ... str.index(str.startIndex, offsetBy: i)] != "\"", str[str.index(str.startIndex, offsetBy: i) ... str.index(str.startIndex, offsetBy: i)] != "\n" {
                i += String(str[str.index(str.startIndex, offsetBy: i) ... str.index(str.startIndex, offsetBy: i)]) == "\\" ? 2 : 1
            }
        } else if !" \t".contains(c) {
            res[i] = regC
        } else if c == "\n" {
            res[i] = endL
        }
        i += 1
    }
    return res
}
