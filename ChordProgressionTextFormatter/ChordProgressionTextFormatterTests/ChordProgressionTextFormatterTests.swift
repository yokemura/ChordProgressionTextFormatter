//
//  ChordProgressionTextFormatterTests.swift
//  ChordProgressionTextFormatterTests
//
//  Created by 除村武志 on 2024/08/13.
//

import XCTest

final class ChordProgressionTextFormatterTests: XCTestCase {
    func testExample() throws {
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
    
    func testThrow() {
        do {
            _ = try Chord.fromString("h#")
            XCTFail("Shouldn't success")
        } catch {
            XCTAssert(error is InvalidRootCharacterException)
        }
    }
}
