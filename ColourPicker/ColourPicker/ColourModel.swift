//
//  ColourModel.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 30/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

/// Stores one colour and its accompanying parameters
class ColourModel: ObservableObject {
  /// A tuple of RGB parameters and their values
  typealias RGBValues = (red: Double, green: Double, blue: Double)
  
  /// A tuple of HSB parameters and their values
  typealias HSBValues = (hue: Double, saturation: Double, brightness: Double)
  
  /// A tuple of CMYK parameters and their values
  typealias CMYKValues = (cyan: Double, magenta: Double, yellow: Double, black: Double)
  
  /// A singleton to ensure more than one instance is not created
  static let shared = ColourModel()
  
  /// Which colour space is being adjusted
  var colourSpace = ColourSpace.HSBA
  
  /// The colour being picked
  @Published var colour = Color.white
  
  //The colour parameters
  @Published var alpha = Double(1) {
    didSet {
      setColour()
    }
  }
  @Published var whiteness = Double(1) {
    didSet {
      colourSpace = .greyscale
      setColour()
    }
  }
  @Published var valuesInRGB = (red: 1.0, green: 0.0, blue: 0.0) {
    didSet {
      colourSpace = .RGBA
      setColour()
    }
  }
  @Published var valuesInHSB = (hue: 1.0, saturation: 0.5, brightness: 1.0) {
    didSet {
      colourSpace = .HSBA
      setColour()
    }
  }
  @Published var valuesInCMYK = (cyan: Double(), magenta: Double(), yellow: Double(), black: Double()) {
    didSet {
      colourSpace = .CMYKA
      setColour()
    }
  }
  
  /// Sets the colour according to which colour space is adjusted
  func setColour() {
    convertFromCurrentColourSpace()
    switch colourSpace {
    case .HSBA:
      colour = Color.fromValues(valuesInHSB, alpha: alpha)
    case .RGBA:
      colour = Color.fromValues(valuesInRGB, alpha: alpha)
    case .CMYKA:
      colour = Color.fromValues(valuesInRGB, alpha: alpha)
    case .greyscale:
      colour = Color(white: whiteness, opacity: alpha)
    }
  }
  
  /// Converts the colour for all colour spaces
  func convertFromCurrentColourSpace() {
    switch colourSpace {
    case .CMYKA:
      valuesInRGB = Color.convertToRGB(valuesInCMYK)
      valuesInHSB = Color.convertToHSB(valuesInCMYK)
    case .RGBA:
      valuesInHSB = Color.convertToHSB(valuesInRGB)
      valuesInCMYK = Color.convertToCMYK(valuesInRGB)
    case .HSBA:
      valuesInRGB = Color.convertToRGB(valuesInHSB)
      valuesInCMYK = Color.convertToCMYK(valuesInHSB)
    case .greyscale:
      break
    }
  }
}

