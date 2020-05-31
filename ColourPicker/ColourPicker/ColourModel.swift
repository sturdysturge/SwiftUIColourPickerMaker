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
  static let shared = ColourModel(colourSpace: .HSBA)
  
  /// Which colour space is being adjusted
  var colourSpace: ColourSpace
  
  var colourCanBeSet = true
  
  /// The colour being picked
  @Published var colour = Color.white
  
  //The colour parameters
  @Published var alpha = Double(1) {
    didSet {
      if colourCanBeSet {
      setColour()
      }
    }
  }
  @Published var white = Double(1) {
    didSet {
      if colourCanBeSet {
      if colourSpace != .greyscale {
        colourSpace = .greyscale
        convertAllFromCurrentColourSpace()
      }
      setColour()
      }
    }
  }
  @Published var valuesInRGBA = (red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0) {
    didSet {
      if colourCanBeSet {
      if colourSpace != .RGBA {
        colourSpace = .RGBA
        convertAllFromCurrentColourSpace()
      }
      setColour()
      }
    }
  }
  @Published var valuesInHSBA = (hue: 1.0, saturation: 0.5, brightness: 1.0, alpha: 1.0) {
    didSet {
      if colourCanBeSet {
      if colourSpace != .HSBA {
        colourSpace = .HSBA
        convertAllFromCurrentColourSpace()
      }
      setColour()
      }
    }
  }
  @Published var valuesInCMYKA = (cyan: Double(0.5), magenta: Double(0.5), yellow: Double(0.5), black: Double(0), alpha: Double(1)) {
    didSet {
      if colourCanBeSet {
      if colourSpace != .CMYKA {
        colourSpace = .CMYKA
        convertAllFromCurrentColourSpace()
      }
      setColour()
      }
    }
  }
  
  init(colourSpace: ColourSpace) {
    self.colourSpace = colourSpace
    self.setColour()
  }
  
  /// Sets the colour according to which colour space is adjusted
  func setColour() {
    switch colourSpace {
    case .HSBA:
      colour = Color.fromValues(valuesInHSBA)
    case .RGBA:
      colour = Color.fromValues(valuesInRGBA)
    case .CMYKA:
      colour = Color.fromValues(valuesInCMYKA)
    case .greyscale:
      colour = Color(white: white, opacity: alpha)
      }
  }
  
  /// Converts the colour for all colour spaces
  func convertAllFromCurrentColourSpace() {
    //Prevents setColour being called when colours are converted
    colourCanBeSet = false
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
      valuesInRGBA = (red: white, green: white, blue: white, alpha: alpha)
      valuesInHSBA = (hue: valuesInHSBA.hue, saturation: 0.0, brightness: white, alpha: alpha)
      valuesInCMYKA = (cyan: 0.0, magenta: 0.0, yellow: 0.0, black: 1.0 - white, alpha: alpha)
    }
    colourCanBeSet = true
  }
}

//extension Color {
//  static func fromValues(_ valuesInHSBA: ColourModel.HSBAValues, alpha: Double = 1) -> Color {
//    return Color(hue: valuesInHSBA.hue, saturation: valuesInHSBA.saturation, brightness: valuesInHSBA.brightness, opacity: valuesInHSBA.alpha)
//  }
//  static func fromValues(_ valuesInRGBA: ColourModel.RGBAValues, alpha: Double = 1) -> Color {
//    return Color(red: valuesInRGBA.red, green: valuesInRGBA.green, blue: valuesInRGBA.blue, opacity: valuesInRGBA.alpha)
//  }
//  static func fromValues(_ valuesInCMYKA: ColourModel.CMYKAValues, alpha: Double = 1) -> Color {
//    return fromValues(convertToRGBA(valuesInCMYKA))
//  }
//  static func convertToRGBA(_ valuesInCMYKA: ColourModel.CMYKAValues) -> ColourModel.RGBAValues {
//    //TODO: Implement conversion function
//    return (red: 0, green: 0, blue: 0, alpha: 0)
//  }
//  static func convertToRGBA(_ valuesInHSBA: ColourModel.HSBAValues) -> ColourModel.RGBAValues {
//    //TODO: Implement conversion function
//    return (red: 0, green: 0, blue: 0, alpha: 0)
//  }
//  static func convertToHSBA(_ valuesInHSBA: ColourModel.RGBAValues) -> ColourModel.HSBAValues {
//    //TODO: Implement conversion function
//    return (hue: 0, saturation: 0, brightness: 0, alpha: 0)
//  }
//  static func convertToHSBA(_ valuesInCMYKA: ColourModel.CMYKAValues) -> ColourModel.HSBAValues {
//    //TODO: Implement conversion function
//    return (hue: 0, saturation: 0, brightness: 0, alpha: 0)
//  }
//  static func convertToCMYKA(_ valuesInHSBA: ColourModel.HSBAValues) -> ColourModel.CMYKAValues {
//    //TODO: Implement conversion function
//    return (cyan: 0, magenta: 0, yellow: 0, black: 0, alpha: 0)
//  }
//  static func convertToCMYKA(_ valuesInRGBA: ColourModel.RGBAValues) -> ColourModel.CMYKAValues {
//    //TODO: Implement conversion function
//    return (cyan: 0, magenta: 0, yellow: 0, black: 0, alpha: 0)
//  }
//}
