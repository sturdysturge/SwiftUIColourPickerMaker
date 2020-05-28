//
//  Enums.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 28/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI


enum ColourSpace: CaseIterable {
  case HSBA, RGBA, CMYKA, greyscale
}
enum Parameter: String, CaseIterable {
  case hue, saturation, brightness, red, green, blue, alpha, whiteness, cyan, magenta, yellow, black
  
  init(colourSpace: ColourSpace, character: String) {
    switch character {
    case "H": self = .hue
    case "S": self = .saturation
    case "R": self = .red
    case "G": self = .green
    case "A": self = .alpha
    case "W": self = .whiteness
    case "C": self = .cyan
    case "M": self = .magenta
    case "Y": self = .yellow
    case "K": self = .black
    case "B": self = colourSpace == .RGBA ? .blue : .brightness
    default: fatalError("Unexpected character \(character)")
    }
  }
}
