//
//  Enums.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 28/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

/// Colours are created with only one of these sets of parameters at a time
enum ColourSpace: CaseIterable {
    case HSBA, RGBA, CMYKA, greyscale

    // TODO: - add to tutorial
    var parameters: [Parameter] {
        switch self {
        case .HSBA:
            return [.hue, .saturation, .brightness, .alpha]
        case .RGBA:
            return [.red, .green, .blue, .alpha]
        case .CMYKA:
            return [.cyan, .magenta, .yellow, .black, .alpha]
        case .greyscale:
            return [.white, .alpha]
        }
    }
}

// TODO: - add to tutorial
enum Parameter: String, CaseIterable {
    case hue, saturation, brightness, red, green, blue, alpha, white, cyan, magenta, yellow, black


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
        case .hue:
            return (red: 1, green: 0, blue: 0, alpha: 1)
        case .saturation:
            return (red: 1, green: 1, blue: 1, alpha: 1)
        case .brightness:
            return (red: 0, green: 0, blue: 0, alpha: 1)
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
        }
    }

    var valuesInCMYK: ColourModel.CMYKAValues {
        return Color.convertToCMYKA(self.valuesInRGB)
    }
}
