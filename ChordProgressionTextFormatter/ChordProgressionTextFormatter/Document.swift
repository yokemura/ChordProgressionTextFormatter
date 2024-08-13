//
//  Document.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/14.
//

import Foundation

struct Document {
    let sections: [Section]
    
    static func fromString(_ string: String) throws -> Document {
        let sectionStrings = string.split(separator: try Regex("\n\n+"))
        
        let sections = try sectionStrings.map {
            return try Section.fromString(String($0))
        }

        return Document(sections: sections)
    }
}
