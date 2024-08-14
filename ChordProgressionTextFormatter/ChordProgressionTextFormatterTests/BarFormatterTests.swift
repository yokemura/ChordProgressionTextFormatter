//
//  BarFormatterTests.swift
//  ChordProgressionTextFormatterTests
//
//  Created by 除村武志 on 2024/08/14.
//

import XCTest

final class BarFormatterTests: XCTestCase {
    func testBasic() throws {
        let bar = Bar(components: [
            .chord(chord: Chord(root: 0, quality: "")), // "C"
            .chord(chord: Chord(root: 0, quality: "")), // "C"
        ])
        
        let formatter = BarFormatter(bar: bar, barWidth: 4)
        let formatted = formatter.formatted
        XCTAssertEqual(formatted, "C C ")
    }

    func testSpacer() throws {
        let bar = Bar(components: [
            .spacer,
            .chord(chord: Chord(root: 0, quality: "")), // "C"
        ])
        
        let formatter = BarFormatter(bar: bar, barWidth: 4)
        let formatted = formatter.formatted
        XCTAssertEqual(formatted, "  C ")
    }

    func testSingle() throws {
        let bar = Bar(components: [
            .chord(chord: Chord(root: 0, quality: "")), // "C"
        ])
        
        let formatter = BarFormatter(bar: bar, barWidth: 4)
        let formatted = formatter.formatted
        XCTAssertEqual(formatted, "C   ")
    }

    func testNormalize1() throws {
        let bar = Bar(components: [
            .chord(chord: Chord(root: 0, quality: "aug")), // "Caug"
            .chord(chord: Chord(root: 0, quality: "")), // "C"
        ])
        
        let formatter = BarFormatter(bar: bar, barWidth: 6)
        let formatted = formatter.formatted
        XCTAssertEqual(formatted, "Caug C")
    }

    func testNormalize2() throws {
        let bar = Bar(components: [
            .chord(chord: Chord(root: 0, quality: "")), // "C"
            .chord(chord: Chord(root: 0, quality: "aug")), // "Caug"
        ])
        
        let formatter = BarFormatter(bar: bar, barWidth: 6)
        let formatted = formatter.formatted
        XCTAssertEqual(formatted, "C Caug")
    }
    
    func testNormalize3() throws {
        let bar = Bar(components: [
            .spacer,
            .chord(chord: Chord(root: 1, quality: "dim")), // "C#dim"
            .chord(chord: Chord(root: 3, quality: "dim")), // "Ebdim"
        ])
        
        let formatter = BarFormatter(bar: bar, barWidth: 12)
        let formatted = formatter.formatted
        XCTAssertEqual(formatted, " C#dim Ebdim")
    }
    
    func testOverflow() throws {
        let bar = Bar(components: [
            .chord(chord: Chord(root: 0, quality: "aug")), // "Caug"
            .chord(chord: Chord(root: 2, quality: "aug")), // "Daug"
        ])
        
        let formatter = BarFormatter(bar: bar, barWidth: 6)
        let formatted = formatter.formatted
        XCTAssertEqual(formatted, "Caug Daug") // exceeds 6 characters
    }

    func testNoChord() throws {
        let bar = Bar(components: [
            .noChord,
        ])
        
        let formatter = BarFormatter(bar: bar, barWidth: 6)
        let formatted = formatter.formatted
        XCTAssertEqual(formatted, "N.C.  ")
    }
}
