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
  
  var parameters: [Parameter] {
    switch self {
      
    case .HSBA:
      return [.hue, .saturation, .brightness, .alpha]
    case .RGBA:
      return [.red, .green, .blue, .alpha]
    case .CMYKA:
      return [.cyan, .magenta, .yellow, .black, .alpha]
    case .greyscale:
      return [.whiteness, .alpha]
    }
  }
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
  
  var isAlpha: Bool {
    return self == .alpha
  }
  
  var colourSpace: ColourSpace {
    switch self {
    case .hue, .saturation, .brightness:
      return .HSBA
    case .red, .green, .blue:
      return .RGBA
    case .alpha, .whiteness:
      return .greyscale
    case .cyan, .magenta, .yellow, .black:
      return .CMYKA
    }
  }
  
  func isSameColourSpace(as otherParameter: Parameter) -> Bool {
    return colourSpace == otherParameter.colourSpace || isAlpha || otherParameter.isAlpha
  }
}
