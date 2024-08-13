//
//  Section.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/13.
//

import Foundation

struct Line {
    let bars: [Bar]
}

struct Section {
    let title: String?
    let lines: [Line]
}
