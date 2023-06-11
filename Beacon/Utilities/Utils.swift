//
//  Utils.swift
//  Beacon
//
//  
//

import Foundation

func runCmd(_ command: (UnsafePointer<Int8>) -> Void, _ input: String) -> String {
    let output = input.withCString { inp in
        let pipe = Pipe()
        var output = ""
        let sema = DispatchSemaphore(value: 0)

        pipe.fileHandleForReading.readabilityHandler = { fileHandle in
            let data = fileHandle.availableData
            if data.isEmpty {
                fileHandle.readabilityHandler = nil
                sema.signal()
            } else {
                output += String(data: data, encoding: .utf8)!
            }
        }
        setvbuf(stdout, nil, _IONBF, 0)
        let savedStdout = dup(STDOUT_FILENO)
        dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO) // start redirecting

        command(inp)

        dup2(savedStdout, STDOUT_FILENO)
        try! pipe.fileHandleForWriting.close()
        close(savedStdout)
        sema.wait()
        return output
    }
    return String(output.dropLast())
}

func cbqnCmd(_ inp: UnsafePointer<Int8>) {
    let ln = Int32(String(cString: inp).count)
    let inp = UnsafeMutablePointer(mutating: inp)
    cbqn_runLine(inp, ln)
}

func kCmd(_ inp: UnsafePointer<Int8>) {
    let a = UnsafeMutablePointer<K>.allocate(capacity: 1)
    let b = UnsafeMutablePointer<K>.allocate(capacity: 1)
    K0(a, String(cString: inp), b, 0)
    a.deallocate()
    b.deallocate()
}

func e(input: String) -> String {
    var input = input
    if input.contains("•Import ") {
        let i = input.split(separator: "•Import ")
        let vars = i[0]
        let filename = i[1].replacingOccurrences(of: "\"", with: "")
        input = "\(vars) •Import \"\(Bundle.main.resourcePath!)/bqn-libs/\(filename)\""
    }
    return runCmd(cbqnCmd, input)
}

func ke(input: String) -> String {
    var input = input.replacingOccurrences(of: "\\", with: #"\\"#)
    input = input.replacingOccurrences(of: "\"", with: #"\""#)
    input = ".[{`0:`k@.\"\(input)\"};[];{`0:(,\"Error: \"),(-2_\"\n\"\\x)}]"
    return runCmd(kCmd, input)
}

extension String {
    func matchingStrings(regex: String) -> [[NSRange]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0 ..< result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound
                    ? result.range(at: $0)
                    : result.range(at: $0)
            }
        }
    }
}

func trimLongText(_ input: String) -> String {
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)
    guard lines.count > 7 else { return input }

    let firstThreeLines = lines.prefix(3).joined(separator: "\n")
    let lastThreeLines = lines.suffix(3).joined(separator: "\n")
    return "\(firstThreeLines)\n...\n\(lastThreeLines)"
}

func removeLastLine(from string: String) -> String {
    guard let range = string.range(of: "\n", options: .backwards) else {
        return ""
    }
    return String(string[..<range.lowerBound])
}
