//  Parameter.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

public enum Parameter: String, CaseIterable {
    case hue, saturation, brightness, red, green, blue, alpha, white, cyan, magenta, yellow, black

    public typealias Pair = (x: Parameter, y: Parameter)

    func checkCompatibility(with otherParameter: Parameter) {
        guard self != otherParameter else {
            fatalError("Parameters should be different")
        }
        guard isSameColourSpace(as: otherParameter) else {
            fatalError("Parameters should be from the same colour space")
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

    var valuesInRGB: ColourModel.RGBAValues {
        switch self {
        case .red:
            return (red: 1, green: 0, blue: 0, alpha: 1)
        case .green:
            return (red: 0, green: 1, blue: 0, alpha: 1)
        case .blue:
            return (red: 0, green: 0, blue: 1, alpha: 1)
        case .alpha:
            return (red: 0, green: 0, blue: 0, alpha: 1)
        case .white:
            return (red: 1, green: 1, blue: 1, alpha: 1)
        case .cyan:
            return (red: 0, green: 1, blue: 1, alpha: 1)
        case .magenta:
            return (red: 1, green: 0, blue: 1, alpha: 1)
        case .yellow:
            return (red: 1, green: 1, blue: 0, alpha: 1)
        case .black:
            return (red: 0, green: 0, blue: 0, alpha: 1)
        default:
            fatalError("No defined RGBA values for parameter \(self)")
        }
    }

    var valuesInCMYK: ColourModel.CMYKAValues {
        return Color.convertToCMYKA(valuesInRGB)
    }
}
