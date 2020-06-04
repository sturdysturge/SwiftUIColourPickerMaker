//
//  PaletteDataStorable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol PaletteDataStorable: DataStorable {
    associatedtype ValueType
    func getSwatchColour(values: ValueType) -> Color
    func getSwatch(xIndex: Int, yIndex: Int) -> ValueType
    func getParameterFromConstants(_ parameter: Parameter) -> Double
    var horizontalSwatches: Int { get }
    var verticalSwatches: Int { get }
    func getSwatchParameter(_ axis: Axis, swatch: ValueType) -> Double
}

extension PaletteDataStorable {
    func getValueFor(_ parameter: Parameter, xIndex: Int, yIndex: Int) -> Double {
        if parameters.0 == parameter {
            return Double(xIndex) / Double(horizontalSwatches - 1)
        } else if parameters.1 == parameter {
            return Double(yIndex) / Double(verticalSwatches - 1)
        } else {
            return getParameterFromConstants(parameter)
        }
    }

    func getSwatchColour(values: ValueType) -> Color {
        if let valuesInRGBA = values as? ColourModel.RGBAValues {
            return Color.fromValues(valuesInRGBA)
        } else if let valuesInHSBA = values as? ColourModel.HSBAValues {
            return Color.fromValues(valuesInHSBA)
        } else if let valuesInCMYKA = values as? ColourModel.CMYKAValues {
            return Color.fromValues(valuesInCMYKA)
        } else {
            fatalError("Unknown data type")
        }
    }

    func getSwatch(xIndex: Int, yIndex: Int) -> ValueType {
        if ValueType.self == ColourModel.RGBAValues.self {
            if let returnValue = (red: getValueFor(.red, xIndex: xIndex, yIndex: yIndex), green: getValueFor(.green, xIndex: xIndex, yIndex: yIndex), blue: getValueFor(.blue, xIndex: xIndex, yIndex: yIndex), alpha: getValueFor(.alpha, xIndex: xIndex, yIndex: yIndex)) as? ValueType {
                return returnValue
            } else {
                fatalError("Could not convert to type \(ValueType.self)")
            }
        } else if ValueType.self == ColourModel.HSBAValues.self {
            if let returnValue = (hue: getValueFor(.hue, xIndex: xIndex, yIndex: yIndex), saturation: getValueFor(.saturation, xIndex: xIndex, yIndex: yIndex), brightness: getValueFor(.brightness, xIndex: xIndex, yIndex: yIndex), alpha: getValueFor(.alpha, xIndex: xIndex, yIndex: yIndex)) as? ValueType {
                return returnValue
            } else {
                fatalError("Could not convert to type \(ValueType.self)")
            }
        } else if ValueType.self == ColourModel.CMYKAValues.self {
            if let returnValue = (cyan: getValueFor(.cyan, xIndex: xIndex, yIndex: yIndex), magenta: getValueFor(.magenta, xIndex: xIndex, yIndex: yIndex), yellow: getValueFor(.yellow, xIndex: xIndex, yIndex: yIndex), black: getValueFor(.black, xIndex: xIndex, yIndex: yIndex), alpha: getValueFor(.alpha, xIndex: xIndex, yIndex: yIndex)) as? ValueType {
                return returnValue
            } else {
                fatalError("Could not convert to type \(ValueType.self)")
            }
        } else {
            fatalError("Unknown type \(ValueType.self)")
        }
    }

    func getSwatchParameter(_ axis: Axis, swatch: ValueType) -> Double {
        let parameter = axis == .horizontal ? parameters.0 : parameters.1
        if let valuesInRGBA = swatch as? ColourModel.RGBAValues {
            switch parameter {
            case .red: return valuesInRGBA.red
            case .green: return valuesInRGBA.green
            case .blue: return valuesInRGBA.blue
            case .alpha: return valuesInRGBA.alpha
            default: fatalError("Parameter \(parameter) not in colour space")
            }
        } else if let valuesInHSBA = swatch as? ColourModel.HSBAValues {
            switch parameter {
            case .hue: return valuesInHSBA.hue
            case .saturation: return valuesInHSBA.saturation
            case .brightness: return valuesInHSBA.brightness
            case .alpha: return valuesInHSBA.alpha
            default: fatalError("Parameter \(parameter) not in colour space")
            }
        } else if let valuesInCMYKA = swatch as? ColourModel.CMYKAValues {
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

    func getParameterFromConstants(_ parameter: Parameter) -> Double {
        if let valuesInRGBA = values as? ColourModel.RGBAValues {
            switch parameter {
            case .red: return valuesInRGBA.red
            case .green: return valuesInRGBA.green
            case .blue: return valuesInRGBA.blue
            case .alpha: return valuesInRGBA.alpha
            default: fatalError("Parameter \(parameter) not in colour space")
            }
        }
        if let valuesInHSBA = values as? ColourModel.HSBAValues {
            switch parameter {
            case .hue: return valuesInHSBA.hue
            case .green: return valuesInHSBA.saturation
            case .brightness: return valuesInHSBA.brightness
            case .alpha: return valuesInHSBA.alpha
            default: fatalError("Parameter \(parameter) not in colour space")
            }
        }
        if let valuesInCMYKA = values as? ColourModel.CMYKAValues {
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
