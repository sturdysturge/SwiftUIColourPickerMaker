//  Gradient.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

extension Gradient {
    static let hue = Gradient(colors: [.red, .yellow, .green, .blue, .indigo, .violet, .red])
    static let blank = Gradient(colors: [])

    func linearGradient(_ axis: Axis) -> LinearGradient {
        if axis == .horizontal {
            return LinearGradient(gradient: self, startPoint: .leading, endPoint: .trailing)
        } else { // axis == .vertical
            return LinearGradient(gradient: self, startPoint: .top, endPoint: .bottom)
        }
    }

    static func fromValues(_ values: ColourModel.RGBAValues, parameter: Parameter) -> Gradient {
        var startColour = values
        var endColour = values
        switch parameter {
        case .red:
            startColour.red = 0
            endColour.red = 1
        case .green:
            startColour.green = 0
            endColour.green = 1
        case .blue:
            startColour.blue = 0
            endColour.blue = 1
        case .alpha:
            startColour.alpha = 0
            endColour.alpha = 1
        default:
            fatalError("Parameter \(parameter) not in colour space")
        }
        return Gradient(colors: [Color.fromValues(startColour), Color.fromValues(endColour)])
    }

    static func fromValues(_ values: ColourModel.HSBAValues, parameter: Parameter) -> Gradient {
        var startColour = values
        var endColour = values
        switch parameter {
        case .hue:
            return Gradient.hue
        case .saturation:
            startColour.saturation = 0
            endColour.saturation = 1
        case .brightness:
            startColour.brightness = 0
            endColour.brightness = 1
        case .alpha:
            startColour.alpha = 0
            endColour.alpha = 1
        default:
            fatalError("Parameter \(parameter) not in colour space")
        }
        return Gradient(colors: [Color.fromValues(startColour), Color.fromValues(endColour)])
    }

    static func fromValues(_ values: ColourModel.CMYKAValues, parameter: Parameter) -> Gradient {
        var startColour = values
        var endColour = values
        switch parameter {
        case .cyan:
            startColour.cyan = 0
            endColour.cyan = 1
        case .magenta:
            startColour.magenta = 0
            endColour.magenta = 1
        case .yellow:
            startColour.yellow = 0
            endColour.yellow = 1
        case .black:
            startColour.black = 0
            endColour.black = 1
        case .alpha:
            startColour.alpha = 0
            endColour.alpha = 1
        default:
            fatalError("Parameter \(parameter) not in colour space")
        }
        return Gradient(colors: [Color.fromValues(startColour), Color.fromValues(endColour)])
    }

    static func fromValues(_ values: ColourModel.GreyscaleValues, parameter: Parameter) -> Gradient {
        var startColour = values
        var endColour = values
        switch parameter {
        case .white:
            startColour.white = 0
            endColour.white = 1
        case .alpha:
            startColour.alpha = 0
            endColour.alpha = 1
        default:
            fatalError("Parameter \(parameter) not in colour space")
        }
        return Gradient(colors: [Color.fromValues(startColour), Color.fromValues(endColour)])
    }

    static func canvasGradient(axis: Axis, horizontal: Parameter, vertical: Parameter) -> Gradient {
        switch horizontal.colourSpace {
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
                    return Gradient(colors: [])
                }
            } else { if vertical == .brightness || vertical == .saturation {
                return Gradient(colors: [])
            } else if vertical == .hue {
                return .hue
            } else {
                return Gradient(colors: [])
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
}
