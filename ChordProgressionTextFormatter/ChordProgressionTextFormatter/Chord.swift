//
//  Chord.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/13.
//

import Foundation

struct InvalidRootCharacterException: Error {
    let character: String
}

struct Chord {
    let root: Int
    let quality: String
    
    static func fromString(_ string: String) throws -> Chord {
        let lowered = string.lowercased()
        
        // Rootの取得
        guard let first = lowered.first else {
            fatalError("Root string should include at least one character.")
        }
        let rootChar = String(first)
        
        let roots = ["c", "", "d", "", "e", "f", "", "g", "", "a", "", "b"]
        guard let index = roots.firstIndex(of: rootChar) else {
            throw InvalidRootCharacterException(character: rootChar)
        }
                
        // 2文字目を取得
        var modification: Int = 0
        if lowered.count >= 2 {
            let secondCharIndex = lowered.index(lowered.startIndex, offsetBy: 1)
            let secondChar = String(lowered[secondCharIndex])
            if ("-b".contains(secondChar)) {
                modification = -1
            } else if ("#+".contains(secondChar)) {
                modification = +1
            }
        }
        
        var root = index + modification
        if (root < 0) {
            root = 11 // Cflat = B
        }
        if (root >= 12) {
            root = 0 // Bsharp = C
        }
        // qualityの取得
        let startIndex = string.index(string.startIndex, offsetBy: 1 + abs(modification))
        let quality = String(string[startIndex...])
        
        return Chord(root: root, quality: quality)
    }
}
