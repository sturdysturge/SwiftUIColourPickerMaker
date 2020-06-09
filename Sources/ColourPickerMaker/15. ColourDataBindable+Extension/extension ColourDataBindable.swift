//  extension ColourDataBindable.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

extension ColourDataBindable where ValueType == ColourModel.RGBAValues {
    func getBackground() -> Color {
        let parameterArray = [parameters.0, parameters.1]
        if parameterArray.contains(.alpha) {
            return .clear
        } else if !parameterArray.contains(.red) {
            return Color(red: values.red, green: 0, blue: 0, opacity: 1)
        } else if !parameterArray.contains(.green) {
            return Color(red: 0, green: values.green, blue: 0, opacity: 1)
        } else if !parameterArray.contains(.blue) {
            return Color(red: 0, green: 0, blue: values.blue, opacity: 1)
        } else {
            fatalError("Parameters \(parameters) contains parameters outside colour space")
        }
    }

    func bindingValues() -> (x: Binding<Double>, y: Binding<Double>) {
        var firstParameter: Binding<Double>
        switch parameters.0 {
        case .red:
            firstParameter = _$values.red
        case .green:
            firstParameter = _$values.green
        case .blue:
            firstParameter = _$values.blue
        case .alpha:
            firstParameter = _$values.alpha
        default:
            fatalError("Parameter \(parameters.0) not in colour space")
        }
        switch parameters.1 {
        case .red:
            return (firstParameter, _$values.red)
        case .green:
            return (firstParameter, _$values.green)
        case .blue:
            return (firstParameter, _$values.blue)
        case .alpha:
            return (firstParameter, _$values.alpha)
        default:
            fatalError("Parameter \(parameters.1) not in colour space")
        }
    }
}

extension ColourDataBindable where ValueType == ColourModel.HSBAValues {
    func getBackground() -> Color {
        let parameterArray = [parameters.0, parameters.1]
        if parameterArray.contains(.saturation) {
            return .white
        } else if parameterArray.contains(.brightness) {
            return .black
        } else if parameterArray.contains(.alpha) || parameterArray.contains(.hue) {
            return .clear
        } else if parameterArray.contains(.saturation), parameterArray.contains(.brightness) {
            return Color(hue: values.hue, saturation: 1, brightness: 1, opacity: 1)
        } else {
            fatalError("Parameters \(parameters) contains parameters outside colour space")
        }
    }

    func bindingValues() -> (x: Binding<Double>, y: Binding<Double>) {
        var firstParameter: Binding<Double>
        switch parameters.0 {
        case .hue:
            firstParameter = _$values.hue
        case .saturation:
            firstParameter = _$values.saturation
        case .brightness:
            firstParameter = _$values.brightness
        case .alpha:
            firstParameter = _$values.alpha
        default:
            fatalError("Parameter \(parameters.0) not in colour space")
        }
        switch parameters.1 {
        case .hue:
            return (firstParameter, _$values.hue)
        case .saturation:
            return (firstParameter, _$values.saturation)
        case .brightness:
            return (firstParameter, _$values.brightness)
        case .alpha:
            return (firstParameter, _$values.alpha)
        default:
            fatalError("Parameter \(parameters.1) not in colour space")
        }
    }
}

extension ColourDataBindable where ValueType == ColourModel.CMYKAValues {
    func getBackground() -> Color {
        let parameterArray = [parameters.0, parameters.1]
        var valuesForBackground = values
        if parameterArray.contains(.alpha) {
            return .clear
        } else {
            let parameters: [Parameter] = [.cyan, .magenta, .yellow, .black]
            parameters.forEach { parameter in
                if parameterArray.contains(parameter) {
                    switch parameter {
                    case .cyan:
                        valuesForBackground.cyan = 0
                    case .magenta:
                        valuesForBackground.magenta = 0
                    case .yellow:
                        valuesForBackground.yellow = 0
                    case .black:
                        valuesForBackground.black = 0
                    default:
                        fatalError("Unknown parameter \(parameter)")
                    }
                }
            }
            return Color.fromValues(valuesForBackground)
        }
    }

    func bindingValues() -> (x: Binding<Double>, y: Binding<Double>) {
        var firstParameter: Binding<Double>
        switch parameters.0 {
        case .cyan:
            firstParameter = _$values.cyan
        case .magenta:
            firstParameter = _$values.magenta
        case .yellow:
            firstParameter = _$values.yellow
        case .black:
            firstParameter = _$values.black
        case .alpha:
            firstParameter = _$values.alpha
        default:
            fatalError("Parameter \(parameters.0) not in colour space")
        }
        switch parameters.1 {
        case .cyan:
            return (firstParameter, _$values.cyan)
        case .magenta:
            return (firstParameter, _$values.magenta)
        case .yellow:
            return (firstParameter, _$values.yellow)
        case .black:
            return (firstParameter, _$values.black)
        case .alpha:
            return (firstParameter, _$values.alpha)
        default:
            fatalError("Parameter \(parameters.1) not in colour space")
        }
    }
}

extension ColourDataBindable where ValueType == ColourModel.GreyscaleValues {
    func getBackground() -> Color {
        return .clear
    }

    func bindingValues() -> (x: Binding<Double>, y: Binding<Double>) {
        if parameters.0 == .white, parameters.1 == .alpha {
            return (_$values.white, _$values.alpha)
        } else if parameters.0 == .alpha, parameters.1 == .white {
            return (_$values.alpha, _$values.white)
        } else {
            fatalError("Parameter \(parameters.1) not in colour space")
        }
    }
}
