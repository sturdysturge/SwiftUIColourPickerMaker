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
  typealias RGBAValues = (red: Double, green: Double, blue: Double, alpha: Double)
  
  /// A tuple of HSB parameters and their values
  typealias HSBAValues = (hue: Double, saturation: Double, brightness: Double, alpha: Double)
  
  /// A tuple of CMYK parameters and their values
  typealias CMYKAValues = (cyan: Double, magenta: Double, yellow: Double, black: Double, alpha: Double)
  
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
  @Published var valuesInRGBA = (red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0) {
    didSet {
      colourSpace = .RGBA
      setColour()
    }
  }
  @Published var valuesInHSBA = (hue: 1.0, saturation: 0.5, brightness: 1.0, alpha: 1.0) {
    didSet {
      colourSpace = .HSBA
      setColour()
    }
  }
  @Published var valuesInCMYKA = (cyan: Double(), magenta: Double(), yellow: Double(), black: Double(), alpha: Double(1)) {
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
      colour = Color.fromValues(valuesInHSBA, alpha: alpha)
    case .RGBA:
      colour = Color.fromValues(valuesInRGBA, alpha: alpha)
    case .CMYKA:
      colour = Color.fromValues(valuesInRGBA, alpha: alpha)
    case .greyscale:
      colour = Color(white: whiteness, opacity: alpha)
    }
  }
  
  /// Converts the colour for all colour spaces
  func convertFromCurrentColourSpace() {
    switch colourSpace {
    case .CMYKA:
      valuesInRGBA = Color.convertToRGBA(valuesInCMYKA)
      valuesInHSBA = Color.convertToHSBA(valuesInCMYKA)
    case .RGBA:
      valuesInHSBA = Color.convertToHSBA(valuesInRGBA)
      valuesInCMYKA = Color.convertToCMYKA(valuesInRGBA)
    case .HSBA:
      valuesInRGBA = Color.convertToRGBA(valuesInHSBA)
      valuesInCMYKA = Color.convertToCMYKA(valuesInHSBA)
    case .greyscale:
      break
    }
  }
}

extension Color {
  static func fromValues(_ valuesInHSBA: ColourModel.HSBAValues, alpha: Double = 1) -> Color {
    return Color(hue: valuesInHSBA.hue, saturation: valuesInHSBA.saturation, brightness: valuesInHSBA.brightness, opacity: valuesInHSBA.alpha)
  }
  static func fromValues(_ valuesInRGBA: ColourModel.RGBAValues, alpha: Double = 1) -> Color {
    return Color(red: valuesInRGBA.red, green: valuesInRGBA.green, blue: valuesInRGBA.blue, opacity: valuesInRGBA.alpha)
  }
  static func fromValues(_ valuesInCMYKA: ColourModel.CMYKAValues, alpha: Double = 1) -> Color {
    return fromValues(convertToRGBA(valuesInCMYKA))
  }
  static func convertToRGBA(_ valuesInCMYKA: ColourModel.CMYKAValues) -> ColourModel.RGBAValues {
    return (red: 0, green: 0, blue: 0, alpha: 0)
  }
  static func convertToRGBA(_ valuesInHSBA: ColourModel.HSBAValues) -> ColourModel.RGBAValues {
    return (red: 0, green: 0, blue: 0, alpha: 0)
  }
  static func convertToHSBA(_ valuesInHSBA: ColourModel.RGBAValues) -> ColourModel.HSBAValues {
    return (hue: 0, saturation: 0, brightness: 0, alpha: 0)
  }
  static func convertToHSBA(_ valuesInCMYKA: ColourModel.CMYKAValues) -> ColourModel.HSBAValues {
    return (hue: 0, saturation: 0, brightness: 0, alpha: 0)
  }
  static func convertToCMYKA(_ valuesInHSBA: ColourModel.HSBAValues) -> ColourModel.CMYKAValues {
    return (cyan: 0, magenta: 0, yellow: 0, black: 0, alpha: 0)
  }
  static func convertToCMYKA(_ valuesInRGBA: ColourModel.RGBAValues) -> ColourModel.CMYKAValues {
    return (cyan: 0, magenta: 0, yellow: 0, black: 0, alpha: 0)
  }
}
