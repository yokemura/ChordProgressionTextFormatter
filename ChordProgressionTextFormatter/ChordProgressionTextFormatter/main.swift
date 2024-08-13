//
//  main.swift
//  ChordProgressionTextFormatter
//
//  Created by 除村武志 on 2024/08/13.
//

import Foundation

print("Hello, World!")

let inputText = """
[A]
Am D7|G |Am D7 |G |
Am |Bm7 |C  | D7|

[B]
D7 | | | |
D7 | | | |
"""

let sections = inputText.split(separator: try! Regex("\n\n+"))

print(sections)
