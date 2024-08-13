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
    case noChord
}

struct Bar {
    let components: [BarComponent]
    
    static func fromString(_ string: String) throws -> Bar {
        let stringComponents = string.split(separator: /\s+/)
        let components: [BarComponent] = try stringComponents.map { compRaw in
            let comp = String(compRaw)
            if comp == "-" {
                return .spacer
            } else if comp.wholeMatch(of: /[Nn]\.?[Cc]\.?/) != nil {
                return .noChord
            } else {
                let chord = try Chord.fromString(comp)
                return .chord(chord: chord)
            }
        }
        return Bar(components: components)
    }
}
