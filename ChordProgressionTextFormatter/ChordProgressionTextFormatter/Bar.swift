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
}
