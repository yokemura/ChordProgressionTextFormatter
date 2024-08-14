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

    var formatted: String {
        let baseCount = barWidth / bar.components.count
        let remainder = barWidth % bar.components.count
        
        var presentations = bar.components.enumerated().map { index, component in
            let isLast = index == bar.components.count - 1
            return BarComponentPresentation(
                essentialString: component.essentialString(isLast: isLast),
                assignedWidth: index < remainder ? baseCount + 1 : baseCount
            )
        }
        
        var isDone = false
        while !isDone {
            let poorest = presentations.min(by: {lhs, rhs in
                lhs.adjustedPaddingCount < rhs.adjustedPaddingCount
            })
            let richest = presentations.max(by: {lhs, rhs in
                lhs.adjustedPaddingCount > rhs.adjustedPaddingCount
            })
            guard var poorest = poorest, var richest = richest else {
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
        essentialString + String.init(repeating: " ", count: idealPaddingCount + paddingCountAdjustment)
    }
    
    var adjustedPaddingCount: Int {
        idealPaddingCount + paddingCountAdjustment
    }

    
    func setPaddingCountAdjustment(_ count: Int) {
        paddingCountAdjustment = count
    }
}

extension BarComponent {
    func essentialString(isLast: Bool) -> String {
        switch self {
        case .chord(let chord):
            let roots = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
            let essentialPadding = isLast ? "" : " "
            return roots[chord.root] + chord.quality + essentialPadding
        case .spacer:
            return ""
        case .noChord:
            return "N.C."
        }
    }
}
