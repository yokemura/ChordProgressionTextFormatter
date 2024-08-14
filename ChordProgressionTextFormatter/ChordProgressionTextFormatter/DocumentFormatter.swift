//
//  DocumentFormatter.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/14.
//

import Foundation

struct DocumentFormatter {
    let document: Document
    let barWidth: Int
    let transpose: Int
    
    init(document: Document, barWidth: Int, transpose: Int = 0) {
        self.document = document
        self.barWidth = barWidth
        self.transpose = transpose
    }
    
    var formatted: String {
        document.lineComponents.map { comp in
            switch comp {
            case .comment(let text):
                return text
            case .line(let line):
                return joinLine(line)
            }
        }.joined(separator: "\n")
    }    

    func joinLine(_ line: Line) -> String {
        let contents = line.bars.map {
            BarFormatter(
                bar: $0,
                barWidth: barWidth,
                transpose: transpose
            ).formatted
        }.joined(separator: "|")
        return "|\(contents)|"
    }
}
