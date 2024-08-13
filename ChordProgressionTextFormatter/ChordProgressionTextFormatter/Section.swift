//
//  Section.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/13.
//

import Foundation

struct SectionEmptyException: Error {}

struct Section {
    let title: String?
    let lines: [Line]
    
    static func fromString(_ string: String) throws -> Section {
        let lines = string.components(separatedBy: .newlines)
        
        guard let firstLine = lines.first else {
            throw SectionEmptyException()
        }
        
        let regex = /\[.*\]/

        if firstLine.contains("|") {
            let lineObjs = try lines.map {
                try Line.fromString($0)
            }
            return Section(title: nil, lines: lineObjs)
        } else {
            let lineObjs = try lines[1...].map {
                try Line.fromString($0)
            }
            return Section(title: firstLine, lines: lineObjs)
        }        
    }
}
