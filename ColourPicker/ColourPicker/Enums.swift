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

    enum CircleDirection {
        case angular, radial
    }

    var gradient: Gradient {
        return Gradient(colors: colours)
    }

    func checkCompatibility(with otherParameter: Parameter) {
        guard self != otherParameter else {
            fatalError("Parameters should be different")
        }
        guard isSameColourSpace(as: otherParameter) else {
            fatalError("Parameters should be from the same colour space")
        }
    }

    func canvasGradient(axis: Axis, otherParameter: Parameter) -> Gradient {
        let horizontal = axis == .horizontal ? self : otherParameter
        let vertical = axis == .vertical ? self : otherParameter
        switch colourSpace {
        case .RGBA:
            let horizontalColour = Color.fromValues(horizontal.valuesInRGB)
            let verticalColour = Color.fromValues(vertical.valuesInRGB)
            let blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInRGB, colour2: vertical.valuesInRGB, alpha: 0.5))
            return axis == .horizontal ?
                Gradient(colors: [verticalColour, blendedColour]) : Gradient(colors: [horizontalColour, blendedColour])
        case .HSBA:
            if axis == .horizontal {
                if horizontal == .brightness || horizontal == .saturation {
                    return Gradient(colors: [])
                } else if horizontal == .hue {
                    return .hue
                } else {
                    let verticalColour = Color.fromValues(vertical.valuesInHSB)
                    let blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInHSB, colour2: vertical.valuesInHSB, alpha: 0.5))
                    return Gradient(colors: [verticalColour, blendedColour])
                }
            } else { if vertical == .brightness || vertical == .saturation {
                return Gradient(colors: [])
            } else if vertical == .hue {
                return .hue
            } else {
                let horizontalColour = Color.fromValues(horizontal.valuesInHSB)
                let blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInHSB, colour2: vertical.valuesInHSB, alpha: 0.5))
                return Gradient(colors: [horizontalColour, blendedColour])
            }
            }
        case .CMYKA:
            let horizontalColour = Color.fromValues(horizontal.valuesInCMYK)
            let verticalColour = Color.fromValues(vertical.valuesInCMYK)
            let blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInCMYK, colour2: vertical.valuesInCMYK, alpha: 0.5))
            return axis == .horizontal ?
                Gradient(colors: [verticalColour, blendedColour]) : Gradient(colors: [horizontalColour, blendedColour])
        case .greyscale:
            return axis == .horizontal ?
                Gradient(colors: [horizontal == .white ? .black : .clear, .white]) : Gradient(colors: [vertical == .white ? .black : .clear, .white])
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

    var valuesInHSB: ColourModel.HSBAValues {
        switch self {
        case .hue:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .saturation:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .brightness:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .red:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .green:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .blue:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .alpha:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .white:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .cyan:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .magenta:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .yellow:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        case .black:
            return (hue: 1, saturation: 0, brightness: 0, alpha: 1)
        }
    }

    var valuesInCMYK: ColourModel.CMYKAValues {
        return Color.convertToCMYKA(self.valuesInRGB)
    }

    var colours: [Color] {
        switch self {
        case .red:
            return [.clear, .red]
        case .green:
            return [.clear, .green]
        case .blue:
            return [.clear, .blue]
        case .cyan:
            return [.clear, .cyan]
        case .magenta:
            return [.clear, .magenta]
        case .yellow:
            return [.clear, Color(red: 1, green: 1, blue: 0, opacity: 0.7)]
        case .hue:
            return [.red, .yellow, .green, .blue, .indigo, .violet, .red]
        case .alpha:
            return [Color(.sRGBLinear, white: 1, opacity: 0.5), Color(.sRGBLinear, white: 1, opacity: 0.9), .white]
        case .black:
            return [.clear, .black]
        case .saturation:
            return [.white, .clear]
        case .brightness:
            return [.black, .clear]
        case .white:
            return [.black, .white]
        }
    }

    func linearGradient(axis: Axis) -> LinearGradient {
        if axis == .horizontal {
            return LinearGradient(gradient: Gradient(colors: colours), startPoint: .leading, endPoint: .trailing)
        } else {
            return LinearGradient(gradient: Gradient(colors: colours), startPoint: .top, endPoint: .bottom)
        }
    }
}
