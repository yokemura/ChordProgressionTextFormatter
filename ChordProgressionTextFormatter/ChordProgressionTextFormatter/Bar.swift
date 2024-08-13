//
//  Bar.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/13.
//

import Foundation

enum BarComponent {
    case chord(chord: Chord)
    case spacer
}

struct Bar {
    let components: [BarComponent]
    
    static func fromString(_ string: String) throws -> Bar {
        let stringComponents = string.components(separatedBy: .whitespaces)
        let components: [BarComponent] = try stringComponents.map { comp in
            if comp == "-" {
                return .spacer
            } else {
                let chord = try Chord.fromString(string)
                return .chord(chord: chord)
            }
        }
        return Bar(components: components)
    }
}
