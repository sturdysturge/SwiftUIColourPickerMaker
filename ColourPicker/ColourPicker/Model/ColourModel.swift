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

    /// A tuple of greyscale parameters and their values
    typealias GreyscaleValues = (white: Double, alpha: Double)

    /// The colour being picked
    @Published var colour = Color.white

    // The colour parameters

    @Published var valuesInRGBA: RGBAValues = (0.0, 0.0, 0.0, 1.0) {
        didSet {
            setColour(colourSpace: .RGBA)
        }
    }

    @Published var valuesInHSBA: HSBAValues = (0.0, 1.0, 1.0, 1.0) {
        didSet {
            setColour(colourSpace: .HSBA)
        }
    }

    @Published var valuesInCMYKA: CMYKAValues = (0.0, 0.0, 0.0, 0.0, 1.0) {
        didSet {
            setColour(colourSpace: .CMYKA)
        }
    }

    @Published var valuesInGreyscale: GreyscaleValues = (0.0, 1.0) {
        didSet {
            setColour(colourSpace: .greyscale)
        }
    }

    init(colourSpace: ColourSpace) {
      setColour(colourSpace: colourSpace)
    }

    /// Allows colour space to be set before setting the colour
    func setColour(colourSpace: ColourSpace) {
        switch colourSpace {
        case .HSBA:
            colour = Color.fromValues(valuesInHSBA)
        case .RGBA:
            colour = Color.fromValues(valuesInRGBA)
        case .CMYKA:
            colour = Color.fromValues(valuesInCMYKA)
        case .greyscale:
            colour = Color.fromValues(valuesInGreyscale)
        }
    }
}
