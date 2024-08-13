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
        var components = string.components(separatedBy: "|")
        let bars: [Bar] = try components.compactMap { comp in
            if comp.isEmpty {
                return nil
            } else {
                return try Bar.fromString(String(comp))
            }
        }
        
        return Line(bars: bars)
    }
}
