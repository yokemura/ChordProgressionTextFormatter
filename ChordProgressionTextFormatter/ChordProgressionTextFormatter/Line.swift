//
//  Line.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村 武志 on 2024/08/13.
//

import Foundation

struct Line {
    let bars: [Bar]
    
    static func fromString(_ string: String) throws -> Line {
        let components = string.components(separatedBy: "|")
        
        return Line(bars: [])
    }
}
