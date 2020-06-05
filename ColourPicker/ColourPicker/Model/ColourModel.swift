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
  
  /// Which colour space is being adjusted
  var colourSpace: ColourSpace
  
  /// The colour being picked
  @Published var colour = Color.white
  
  // The colour parameters
  @Published var alpha = Double(1) {
    didSet {
      //Colour space independent
      setColour()
    }
  }
  
  @Published var white = 1.0 {
    didSet {
      setColour(colourSpace: .greyscale)
    }
  }
  
  @Published var valuesInRGBA: RGBAValues = (1.0, 0.0, 0.0, 1.0) {
    didSet {
      setColour(colourSpace: .RGBA)
    }
  }
  
  @Published var valuesInHSBA: HSBAValues = (1.0, 0.0, 0.0, 1.0) {
    didSet {
      setColour(colourSpace: .HSBA)
    }
  }
  
  @Published var valuesInCMYKA: CMYKAValues = (0.5, 0.5, 0.5, 0.0, 1.0) {
    didSet {
      setColour(colourSpace: .CMYKA)
    }
  }
  
  init(colourSpace: ColourSpace) {
    self.colourSpace = colourSpace
    setColour()
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
  
  /// Allows colour space to be set before setting the colour
  func setColour(colourSpace: ColourSpace) {
    self.colourSpace = colourSpace
    setColour()
  }
  
  /// Get a specific parameter from a generic values tuple
  /// - Parameters:
  ///   - constants: The tuple of unknown type
  ///   - parameter: The parameter in the same colour space
  /// - Returns: A constant Double value for that parameter
  static func getConstantFrom<T>(_ constants: T, for parameter: Parameter) -> Double {
    if let valuesInRGBA = constants as? ColourModel.RGBAValues {
      switch parameter {
      case .red: return valuesInRGBA.red
      case .green: return valuesInRGBA.green
      case .blue: return valuesInRGBA.blue
      case .alpha: return valuesInRGBA.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
      }
    } else if let valuesInHSBA = constants as? ColourModel.HSBAValues {
      switch parameter {
      case .hue: return valuesInHSBA.hue
      case .green: return valuesInHSBA.saturation
      case .brightness: return valuesInHSBA.brightness
      case .alpha: return valuesInHSBA.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
      }
    } else if let valuesInCMYKA = constants as? ColourModel.CMYKAValues {
      switch parameter {
      case .cyan: return valuesInCMYKA.cyan
      case .magenta: return valuesInCMYKA.magenta
      case .yellow: return valuesInCMYKA.yellow
      case .black: return valuesInCMYKA.black
      case .alpha: return valuesInCMYKA.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
      }
    } else {
      fatalError("Unknown type")
    }
  }
}
