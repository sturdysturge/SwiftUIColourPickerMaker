//
//  ColourModel.swift
//
//
//  Created by Rob Sturgeon on 23/05/2020.
//

import SwiftUI

/// Stores one colour and its accompanying parameters
class ColourModel: ObservableObject {
    /// A singleton to ensure more than one instance is not created
    static let shared = ColourModel()

    /// Which colour space is being adjusted
    enum ColourSpace {
        case HSB, RGB, CMYK
    }

    /// The colour being picked
    @Published var colour = Color.white

    /// The value of hue between 0 and 1 in the HSB colour space
    @Published var hue = Double(0.5) {
        didSet {
            setColour(colourSpace: .HSB)
        }
    }

    /// The value of saturation between 0 and 1 in the HSB colour space
    @Published var saturation = Double(1) {
        didSet {
            setColour(colourSpace: .HSB)
        }
    }

    /// The value of brightness between 0 and 1 in the HSB colour space
    @Published var brightness = Double(1) {
        didSet {
            setColour(colourSpace: .HSB)
        }
    }

    /// The value of alpha between 0 and 1 in any colour space
    @Published var alpha = Double(1) {
        didSet {
            setColour(colourSpace: .HSB)
        }
    }

    /// The value of red between 0 and 1 in the RGB colour space
    @Published var red = Double(1) {
        didSet {
            setColour(colourSpace: .RGB)
        }
    }

    /// The value of green between 0 and 1 in the RGB colour space
    @Published var green = Double(1) {
        didSet {
            setColour(colourSpace: .RGB)
        }
    }

    /// The value of blue between 0 and 1 in the RGB colour space
    @Published var blue = Double(1) {
        didSet {
            setColour(colourSpace: .RGB)
        }
    }
  
  /// The value of cyan between 0 and 1 in the CMYK colour space
  @Published var cyan = Double() {
    didSet {
      setColour(colourSpace: .CMYK)
    }
  }
  
  /// The value of magenta between 0 and 1 in the CMYK colour space
  @Published var magenta = Double() {
    didSet {
      setColour(colourSpace: .CMYK)
    }
  }
  
  /// The value of yellow between 0 and 1 in the CMYK colour space
  @Published var yellow = Double() {
    didSet {
      setColour(colourSpace: .CMYK)
    }
  }
  
  /// The value of black between 0 and 1 in the CMYK colour space
  @Published var black = Double() {
    didSet {
      setColour(colourSpace: .CMYK)
    }
  }

    /// Sets the colour according to which colour space is adjusted
    /// - Parameter colourSpace: Whether to use HSB or RGB to update the colour
    func setColour(colourSpace: ColourSpace) {
        switch colourSpace {
        case .HSB:
          let convertedValues = Color.convertHSBToRGBValues(hue: hue, saturation: saturation, brightness: brightness)
          red = convertedValues.red
          green = convertedValues.green
          blue = convertedValues.blue
            colour = Color(hue: hue, saturation: saturation, brightness: brightness, opacity: alpha)
        case .RGB:
          let convertedValues = Color.convertRGBToHSBValues(red: red, green: green, blue: blue)
          hue = convertedValues.hue
          saturation = convertedValues.saturation
          brightness = convertedValues.brightness
            colour = Color(red: red, green: green, blue: blue, opacity: alpha)
        case .CMYK:
          colour = Color.fromCMYK(cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: alpha)
        }
    }
}
