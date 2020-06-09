//  ColorExtendable.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

protocol ColorExtendable {
    /// The colour indigo is needed for the hue gradient
    static var indigo: Color { get }
    /// The colour violet is needed for the hue gradient
    static var violet: Color { get }
    /// The colour cyan needed for the CMYKA colour space
    static var cyan: Color { get }
    /// The colour magenta needed for the CMYKA colour space
    static var magenta: Color { get }
    /// Get a blend of two colours by adding the components together
    static func blend(colour1: ColourModel.RGBAValues, colour2: ColourModel.RGBAValues, alpha: Double) -> ColourModel.RGBAValues
    /// Get a blend of two colours by adding the components together
    static func blend(colour1: ColourModel.HSBAValues, colour2: ColourModel.HSBAValues, alpha: Double) -> ColourModel.HSBAValues
    /// Get a blend of two colours by adding the components together
    static func blend(colour1: ColourModel.CMYKAValues, colour2: ColourModel.CMYKAValues, alpha: Double) -> ColourModel.CMYKAValues
    /// A way to create Color instances from HSBA tuples
    /// - Parameters:
    ///   - valuesInGreyscale: A tuple containing white and alpha as Doubles
    /// - Returns: A colour made from the tuple's parameters
    static func fromValues(_ valuesInGreyscale: ColourModel.GreyscaleValues) -> Color
    /// A way to create Color instances from HSBA tuples
    /// - Parameters:
    ///   - valuesInHSBA: A tuple containing hue, saturation and brightness as Doubles
    ///   - alpha: The optional alpha component (set to 1 if not passed)
    /// - Returns: A colour made from the tuple's parameters
    static func fromValues(_ valuesInHSBA: ColourModel.HSBAValues) -> Color
    /// A way to create Color instances from HSBA tuples
    /// - Parameters:
    ///   - valuesInCMYKA: A tuple containing cyan, magenta, yellow, black and alpha as Doubles
    /// - Returns: A colour made from the tuple's parameters
    static func fromValues(_ valuesInCMYKA: ColourModel.CMYKAValues) -> Color
    /// A way to create Color instances from RGBA tuples
    /// - Parameters:
    ///   - valuesInRGBA: A tuple containing red, green and blue as Doubles
    ///   - alpha: The optional alpha component (set to 1 if not passed)
    /// - Returns: A colour made from the tuple's parameters
    static func fromValues(_ valuesInRGBA: ColourModel.RGBAValues) -> Color
    /// Convert CMYKA values to RGBA values
    /// - Parameters:
    ///   - valuesInCMYKA: A tuple containing cyan, magenta, yellow and black as Doubles
    /// - Returns: A tuple containing red, green and blue as Doubles
    static func convertToRGBA(_ valuesInCMYKA: ColourModel.CMYKAValues) -> ColourModel.RGBAValues
    /// Convert RGBA values to CMYKA values
    /// - Parameters:
    ///   - valuesInRGBA: A tuple containing red, green and blue as Doubles
    /// - Returns: A tuple containing cyan, magenta, yellow and black as Doubles
    static func convertToCMYKA(_ valuesInRGBA: ColourModel.RGBAValues) -> ColourModel.CMYKAValues
}

extension Color: ColorExtendable {
    #if canImport(UIKit)
    static let cyan = Color(UIColor.cyan)
    static let magenta = Color(UIColor.magenta)
    #else
    static let cyan = Color(NSColor.cyan)
    static let magenta = Color(NSColor.magenta)
    #endif
    static let indigo = Color(red: 0.29, green: 0, blue: 0.5)
    static let violet = Color(red: 0.93, green: 0.5, blue: 0.93)
  
    static func blend(colour1: ColourModel.RGBAValues, colour2: ColourModel.RGBAValues, alpha: Double) -> ColourModel.RGBAValues {
        let red = (colour1.red + colour2.red).clampFromZero(to: 1)
        let green = (colour1.green + colour2.green).clampFromZero(to: 1)
        let blue = (colour1.blue + colour2.blue).clampFromZero(to: 1)
        return (red: red, green: green, blue: blue, alpha: alpha)
    }

    static func blend(colour1: ColourModel.HSBAValues, colour2: ColourModel.HSBAValues, alpha: Double) -> ColourModel.HSBAValues {
        let hue = (colour1.hue + colour2.hue).clampFromZero(to: 1)
        let saturation = (colour1.saturation + colour2.saturation).clampFromZero(to: 1)
        let brightness = (colour1.brightness + colour2.brightness).clampFromZero(to: 1)
        return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    static func blend(colour1: ColourModel.CMYKAValues, colour2: ColourModel.CMYKAValues, alpha: Double) -> ColourModel.CMYKAValues {
        let cyan = (colour1.cyan + colour2.cyan).clampFromZero(to: 1)
        let magenta = (colour1.magenta + colour2.magenta).clampFromZero(to: 1)
        let yellow = (colour1.yellow + colour2.yellow).clampFromZero(to: 1)
        let black = (colour1.black + colour2.black).clampFromZero(to: 1)
        return (cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: alpha)
    }

    static func fromValues(_ valuesInGreyscale: ColourModel.GreyscaleValues) -> Color {
        return Color(white: valuesInGreyscale.white, opacity: valuesInGreyscale.alpha)
    }

    static func fromValues(_ valuesInHSBA: ColourModel.HSBAValues) -> Color {
        return Color(hue: valuesInHSBA.hue, saturation: valuesInHSBA.saturation, brightness: valuesInHSBA.brightness, opacity: valuesInHSBA.alpha)
    }

    static func fromValues(_ valuesInCMYKA: ColourModel.CMYKAValues) -> Color {
        return fromValues(convertToRGBA(valuesInCMYKA))
    }

    static func fromValues(_ valuesInRGBA: ColourModel.RGBAValues) -> Color {
        return Color(red: valuesInRGBA.red, green: valuesInRGBA.green, blue: valuesInRGBA.blue, opacity: valuesInRGBA.alpha)
    }

    static func convertToRGBA(_ valuesInCMYKA: ColourModel.CMYKAValues) -> ColourModel.RGBAValues {
        let red = (1 - valuesInCMYKA.cyan) * (1 - valuesInCMYKA.black)
        let green = (1 - valuesInCMYKA.magenta) * (1 - valuesInCMYKA.black)
        let blue = (1 - valuesInCMYKA.yellow) * (1 - valuesInCMYKA.black)
        return (red: red, green: green, blue: blue, alpha: valuesInCMYKA.alpha)
    }

    static func convertToCMYKA(_ valuesInRGBA: ColourModel.RGBAValues) -> ColourModel.CMYKAValues {
        guard let max = [valuesInRGBA.red, valuesInRGBA.green, valuesInRGBA.blue].max() else {
            fatalError("Could not find maximum value")
        }
        let black = 1 - max
        let cyan = (1 - valuesInRGBA.red - black) / (1 - black)
        let magenta = (1 - valuesInRGBA.green - black) / (1 - black)
        let yellow = (1 - valuesInRGBA.blue - black) / (1 - black)

        return (cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: valuesInRGBA.alpha)
    }
}
