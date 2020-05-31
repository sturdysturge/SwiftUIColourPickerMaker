//
//  Enums.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 28/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI
public enum GradientType {
  case red, green, blue, brightnessOverlay, saturationOverlay, hue, alpha, cyan, yellow, purple, magenta, black
  
  var colours: [Color] {
    switch self {
    case .red:
      return [.clear, .red]
    case .green:
      return [.clear, .green]
    case .blue:
      return [.clear, .blue]
    case .cyan:
      return [.clear, .cyan]
    case .magenta:
      return [.clear, .magenta]
    case .yellow:
      return [.clear, Color(red: 1, green: 1, blue: 0, opacity: 0.7)]
    case .purple:
      return [.clear, Color(red: 1, green: 0, blue: 1, opacity: 0.5)]
    case .brightnessOverlay:
      return [.black, Color(.sRGBLinear, white: 0, opacity: 0.7), Color(.sRGBLinear, white: 0, opacity: 0.5), Color(.sRGBLinear, white: 0, opacity: 0.3)]
    case .saturationOverlay:
      return [.white, Color(.sRGBLinear, white: 1, opacity: 0.9), Color(.sRGBLinear, white: 1, opacity: 0.5), Color(.sRGBLinear, white: 1, opacity: 0.3)]
    case .hue:
      return [.red, .yellow, .green, .blue, .indigo, .violet, .red]
    case .alpha:
      return [Color(.sRGBLinear, white: 1, opacity: 0.5), Color(.sRGBLinear, white: 1, opacity: 0.9), .white]
    case .black:
      return [.clear, .black]
    }
  }
  
  var horizontal: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: colours), startPoint: .leading, endPoint: .trailing)
  }
  
  var vertical: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: colours), startPoint: .top, endPoint: .bottom)
  }
}

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
      return [.white, .alpha]
    }
  }
}
enum Parameter: String, CaseIterable {
  case hue, saturation, brightness, red, green, blue, alpha, white, cyan, magenta, yellow, black
  
  init(colourSpace: ColourSpace, character: String) {
    switch character {
    case "H": self = .hue
    case "S": self = .saturation
    case "R": self = .red
    case "G": self = .green
    case "A": self = .alpha
    case "W": self = .white
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
    case .alpha, .white:
      return .greyscale
    case .cyan, .magenta, .yellow, .black:
      return .CMYKA
    }
  }
  
  func isSameColourSpace(as otherParameter: Parameter) -> Bool {
    return colourSpace == otherParameter.colourSpace || isAlpha || otherParameter.isAlpha
  }
}
