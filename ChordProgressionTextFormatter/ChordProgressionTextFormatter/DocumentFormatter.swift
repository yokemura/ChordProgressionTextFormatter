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
    
    var formatted: String {
        document.sections.map {
            joinSection($0)
        }.joined(separator: "\n\n")
    }
    
    func joinSection(_ section: Section) -> String {
        let contents = section.lines.map {
            joinLine($0)
        }.joined(separator: "\n")
        
        if let title = section.title {
            return title + "\n" + contents
        } else {
            return contents
        }
    }
    
    func joinLine(_ line: Line) -> String {
        let contents = line.bars.map {
            BarFormatter(bar: $0, barWidth: barWidth).formatted
        }.joined(separator: "|")
        return "|\(contents)|"
    }
}
