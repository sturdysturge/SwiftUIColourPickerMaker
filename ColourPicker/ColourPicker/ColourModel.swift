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

    /// The colour being picked
    @Published var colour = Color.white

    // The colour parameters
    @Published var alpha = Double(1) {
        didSet {
            setColour()
        }
    }

    @Published var white = Double(1) {
        didSet {
            if colourSpace != .greyscale {
                colourSpace = .greyscale
            }
            setColour()
        }
    }

    @Published var valuesInRGBA = (red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0) {
        didSet {
            if colourSpace != .RGBA {
                colourSpace = .RGBA
            }
            setColour()
        }
    }

    @Published var valuesInHSBA = (hue: 1.0, saturation: 0.5, brightness: 1.0, alpha: 1.0) {
        didSet {
            if colourSpace != .HSBA {
                colourSpace = .HSBA
            }
            setColour()
        }
    }

    @Published var valuesInCMYKA = (cyan: Double(0.5), magenta: Double(0.5), yellow: Double(0.5), black: Double(0), alpha: Double(1)) {
        didSet {
            if colourSpace != .CMYKA {
                colourSpace = .CMYKA
            }
            setColour()
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
}
