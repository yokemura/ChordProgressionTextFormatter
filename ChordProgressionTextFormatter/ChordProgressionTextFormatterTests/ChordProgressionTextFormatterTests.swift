//
//  ChordProgressionTextFormatterTests.swift
//  ChordProgressionTextFormatterTests
//
//  Created by 除村武志 on 2024/08/13.
//

import XCTest

final class ChordProgressionTextFormatterTests: XCTestCase {
    func testChords() throws {
        var c: Chord;
        
        //
        // Modifiers
        //
        c = try Chord.fromString("c")
        XCTAssertEqual(c.root, 0)
        XCTAssertEqual(c.quality, "")
        
        c = try Chord.fromString("C") // Case insensitive
        XCTAssertEqual(c.root, 0)
        XCTAssertEqual(c.quality, "")
        
        c = try Chord.fromString("c#")
        XCTAssertEqual(c.root, 1)
        XCTAssertEqual(c.quality, "")

        c = try Chord.fromString("c+")
        XCTAssertEqual(c.root, 1)
        XCTAssertEqual(c.quality, "")

        c = try Chord.fromString("b")
        XCTAssertEqual(c.root, 11)
        XCTAssertEqual(c.quality, "")

        c = try Chord.fromString("b-")
        XCTAssertEqual(c.root, 10)
        XCTAssertEqual(c.quality, "")

        c = try Chord.fromString("bb")
        XCTAssertEqual(c.root, 10)
        XCTAssertEqual(c.quality, "")

        // Overflow
        c = try Chord.fromString("b#")
        XCTAssertEqual(c.root, 0)
        XCTAssertEqual(c.quality, "")

        c = try Chord.fromString("c-") // Cflat
        XCTAssertEqual(c.root, 11) // B
        XCTAssertEqual(c.quality, "")

        //
        // Quality
        //
        c = try Chord.fromString("cm")
        XCTAssertEqual(c.root, 0)
        XCTAssertEqual(c.quality, "m")

        c = try Chord.fromString("cM7")
        XCTAssertEqual(c.root, 0)
        XCTAssertEqual(c.quality, "M7") // Case sensitive

        c = try Chord.fromString("cm7-5")
        XCTAssertEqual(c.root, 0)
        XCTAssertEqual(c.quality, "m7-5") // OK to be long

        //
        // Modifier and Quality
        //
        c = try Chord.fromString("c#m")
        XCTAssertEqual(c.root, 1)
        XCTAssertEqual(c.quality, "m")

        c = try Chord.fromString("bbm")
        XCTAssertEqual(c.root, 10)
        XCTAssertEqual(c.quality, "m")
    }
    
    func testChordsThrow() {
        do {
            _ = try Chord.fromString("h#")
            XCTFail("Shouldn't success")
        } catch {
            XCTAssert(error is InvalidRootCharacterException)
        }
    }
    
    func testBars() throws {
        var b = try Bar.fromString("c d")
        XCTAssertEqual(b.components.count, 2)
        switch b.components[0] {
        case .chord(let chord):
            XCTAssertEqual(chord.root, 0)
        case .spacer, .noChord:
            XCTFail("Should be a Chord")
        }

        switch b.components[1] {
        case .chord(let chord):
            XCTAssertEqual(chord.root, 2)
        case .spacer, .noChord:
            XCTFail("Should be a Chord")
        }

        // Extra space and complex chord
        b = try Bar.fromString("  C#m7   F#7(9) ")
        XCTAssertEqual(b.components.count, 2)
        switch b.components[0] {
        case .chord(let chord):
            XCTAssertEqual(chord.root, 1)
            XCTAssertEqual(chord.quality, "m7")
        case .spacer, .noChord:
            XCTFail("Should be a Chord")
        }

        switch b.components[1] {
        case .chord(let chord):
            XCTAssertEqual(chord.root, 6)
            XCTAssertEqual(chord.quality, "7(9)")
        case .spacer, .noChord:
            XCTFail("Should be a Chord")
        }
        
        // Spacer
        b = try Bar.fromString("- - C7 ")
        XCTAssertEqual(b.components.count, 3)
        switch b.components[0] {
        case .chord, .noChord:
            XCTFail("Should be a Spacer")
        case .spacer:
            break // OK
        }

        switch b.components[1] {
        case .chord, .noChord:
            XCTFail("Should be a Spacer")
        case .spacer:
            break // OK
        }

        switch b.components[2] {
        case .chord(let chord):
            XCTAssertEqual(chord.root, 0)
            XCTAssertEqual(chord.quality, "7")
        case .spacer, .noChord:
            XCTFail("Should be a Chord")
        }

        // NoChord
        b = try Bar.fromString("nc n.c NC. N.c. ")
        XCTAssertEqual(b.components.count, 4)
        b.components.forEach {
            switch $0 {
            case .chord, .spacer:
                XCTFail("Should be a NoChord")
            case .noChord:
                break // OK
            }
        }
    }
    
    func testLines() throws {
        var l = try Line.fromString("|C Am |D7  |")
        XCTAssertEqual(l.bars.count, 2)
        
        // No leading "|"
        l = try Line.fromString("C Am |D7  |")
        XCTAssertEqual(l.bars.count, 2)
        
        // No trailing "|"
        l = try Line.fromString("C Am |D7  ")
        XCTAssertEqual(l.bars.count, 2)
        
        // Multiple "|"s
        l = try Line.fromString("|C Am |D7  ||")
        XCTAssertEqual(l.bars.count, 2)
    }
    
    func testDocument() throws {
        let inputText = """

[A]
Am D7|G |Am D7 |G |
Am |Bm7 |C  | D7|

[B]
D7 | | | |
D7 | | | |

"""
        let doc = try Document.fromString(inputText)
        
        XCTAssertEqual(doc.sections.count, 2)

    }
    
}
