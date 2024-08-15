//
//  ChordProgressionTextFormatter.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/15.
//

import Foundation
import ArgumentParser

struct ChordProgressionTextFormatter: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "cptf",
        abstract: "Formats text-written chord progression",
        discussion: """
        Adjusts spaces so it looks good with non-propotional fonts. Also provides option to transpose.
        """,
        version: "1.0.0",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    @Option(name: .shortAndLong,
            help: "transpose")
    var transpose: Int = 0
    
    @Option(name: .shortAndLong,
            help: "bar width")
    var width: Int = 12
    
    func run() throws {
        var input = ""
        while let line = readLine(strippingNewline: false) {
            input += line
        }
        
        let doc = try! Document.fromString(input)

        let out = DocumentFormatter(document: doc, barWidth: width, transpose: transpose).formatted
        
        print(out)
    }
}
