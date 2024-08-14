//
//  Document.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/14.
//

import Foundation

enum LineComponent {
    case line(line: Line)
    case comment(text: String)
}

struct Document {
    let lineComponents: [LineComponent]
    
    static func fromString(_ string: String) throws -> Document {
        let lines = string.components(separatedBy: .newlines)
        
        let components: [LineComponent] = try lines.map { lineStr in
            if lineStr.contains("|") {
                let line = try Line.fromString(lineStr)
                return .line(line: line)
            } else {
                return .comment(text: lineStr)
            }
        }
        
        return Document(lineComponents: components)
    }
}
