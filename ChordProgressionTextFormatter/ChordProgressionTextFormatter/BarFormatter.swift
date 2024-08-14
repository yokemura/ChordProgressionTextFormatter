//
//  BarFormatter.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/14.
//

import Foundation

struct BarFormatter {
    let bar: Bar
    let barWidth: Int
    let transpose: Int

    init(bar: Bar, barWidth: Int, transpose: Int = 0) {
        self.bar = bar
        self.barWidth = barWidth
        self.transpose = transpose
    }
    
    var formatted: String {
        if bar.components.count == 0 {
            return String.init(repeating: " ", count: barWidth)
        }
        
        let baseCount = barWidth / bar.components.count
        let remainder = barWidth % bar.components.count
        
        let presentations = bar.components.enumerated().map { index, component in
            let isLast = index == bar.components.count - 1
            let essentialString = component.essentialString(isLast: isLast, transpose: transpose)
            let assignedWidth = index < remainder ? baseCount + 1 : baseCount
            return BarComponentPresentation(
                essentialString: essentialString,
                assignedWidth: assignedWidth
            )
        }
        
        var isDone = false
        while !isDone {
            let poorest = presentations.min(by: {lhs, rhs in
                lhs.adjustedPaddingCount < rhs.adjustedPaddingCount
            })
            let richest = presentations.max(by: {lhs, rhs in
                lhs.adjustedPaddingCount < rhs.adjustedPaddingCount
            })
            guard let poorest = poorest, let richest = richest else {
                // No consideration needed
                isDone = true
                continue
            }
            if poorest.adjustedPaddingCount >= 0 {
                // No more adjustment needed
                isDone = true
                continue
            }
            if richest.adjustedPaddingCount <= 0 {
                // No more adjustment resource
                isDone = true
                continue
            }
            // The richest gives the padding to the poorest
            richest.setPaddingCountAdjustment(richest.paddingCountAdjustment - 1)
            poorest.setPaddingCountAdjustment(poorest.paddingCountAdjustment + 1)
        }
        
        let string = presentations.map { $0.paddedString }.joined()
        return string
    }
}

class BarComponentPresentation {
    let essentialString: String
    let assignedWidth: Int
    var paddingCountAdjustment: Int // can be mutated
    
    init(essentialString: String, assignedWidth: Int) {
        self.essentialString = essentialString
        self.assignedWidth = assignedWidth
        self.paddingCountAdjustment = 0
    }
    
    var idealPaddingCount: Int {
        assignedWidth - essentialString.count
    }
    
    var paddedString: String {
        let count = idealPaddingCount + paddingCountAdjustment
        return essentialString + String.init(repeating: " ", count: count < 0 ? 0 : count)
    }
    
    var adjustedPaddingCount: Int {
        idealPaddingCount + paddingCountAdjustment
    }

    
    func setPaddingCountAdjustment(_ count: Int) {
        paddingCountAdjustment = count
    }
}

extension BarComponent {
    func essentialString(isLast: Bool, transpose: Int) -> String {
        switch self {
        case .chord(let chord):
            let roots = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
            let essentialPadding = isLast ? "" : " "
            
            var root = chord.root + transpose
            if root < 0 { root += 12 }
            if root >= 12 { root -= 12 }
            
            return roots[root] + chord.quality + essentialPadding
        case .spacer:
            return ""
        case .noChord:
            return "N.C."
        }
    }
}
