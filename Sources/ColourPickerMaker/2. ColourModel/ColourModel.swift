//  ColourModel.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

/// Stores one colour and its accompanying parameters
public class ColourModel: ObservableObject {
    /// A tuple of RGB parameters and their values
    public typealias RGBAValues = (red: Double, green: Double, blue: Double, alpha: Double)

    /// A tuple of HSB parameters and their values
    public typealias HSBAValues = (hue: Double, saturation: Double, brightness: Double, alpha: Double)

    /// A tuple of CMYK parameters and their values
    public typealias CMYKAValues = (cyan: Double, magenta: Double, yellow: Double, black: Double, alpha: Double)

    /// A tuple of greyscale parameters and their values
    public typealias GreyscaleValues = (white: Double, alpha: Double)

    /// Which colour space is being adjusted
    var colourSpace: ColourSpace

    /// The colour being picked
    @Published public var colour = Color.white

    // The colour parameters
    @Published public var alpha = Double(1) {
        didSet {
            // Colour space independent
            setColour()
        }
    }

    @Published public var valuesInRGBA: RGBAValues = (1.0, 0.0, 0.0, 1.0) {
        didSet {
            setColour(colourSpace: .RGBA)
        }
    }

    @Published public var valuesInHSBA: HSBAValues = (1.0, 1.0, 1.0, 1.0) {
        didSet {
            setColour(colourSpace: .HSBA)
        }
    }

    @Published public var valuesInCMYKA: CMYKAValues = (0.5, 0.5, 0.5, 0.0, 1.0) {
        didSet {
            setColour(colourSpace: .CMYKA)
        }
    }

    @Published public var valuesInGreyscale: GreyscaleValues = (1.0, 1.0) {
        didSet {
            setColour(colourSpace: .greyscale)
        }
    }

    public init(colourSpace: ColourSpace) {
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
            colour = Color.fromValues(valuesInGreyscale)
        }
    }

    /// Allows colour space to be set before setting the colour
    func setColour(colourSpace: ColourSpace) {
        self.colourSpace = colourSpace
        setColour()
    }
}

/// Colours are created with only one of these sets of parameters at a time
public enum ColourSpace: CaseIterable {
    case HSBA, RGBA, CMYKA, greyscale
}
