//
//  DataStorable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol DataStorable {
    associatedtype ValueType
    var values: ValueType { get }
    var _$values: Binding<ValueType> { get }
    func bindingValues() -> (Binding<Double>, Binding<Double>)
    var parameters: (Parameter, Parameter) { get }
    func getHue() -> Double?
}

extension DataStorable {
    func getHue() -> Double? {
        if let values = values as? ColourModel.HSBAValues {
            return values.hue
        } else {
            return nil
        }
    }

    func bindingValues() -> (Binding<Double>, Binding<Double>) {
        if let valuesInRGBA = _$values as? Binding<ColourModel.RGBAValues> {
            var firstParameter: Binding<Double>
            switch parameters.0 {
            case .red:
                firstParameter = valuesInRGBA.red
            case .green:
                firstParameter = valuesInRGBA.green
            case .blue:
                firstParameter = valuesInRGBA.blue
            case .alpha:
                firstParameter = valuesInRGBA.alpha
            default:
                fatalError("Parameter \(parameters.0) not in colour space")
            }
            switch parameters.1 {
            case .red:
                return (firstParameter, valuesInRGBA.red)
            case .green:
                return (firstParameter, valuesInRGBA.green)
            case .blue:
                return (firstParameter, valuesInRGBA.blue)
            case .alpha:
                return (firstParameter, valuesInRGBA.alpha)
            default:
                fatalError("Parameter \(parameters.1) not in colour space")
            }
        } else if let valuesInHSBA = _$values as? Binding<ColourModel.HSBAValues> {
            var firstParameter: Binding<Double>
            switch parameters.0 {
            case .hue:
                firstParameter = valuesInHSBA.hue
            case .saturation:
                firstParameter = valuesInHSBA.saturation
            case .brightness:
                firstParameter = valuesInHSBA.brightness
            case .alpha:
                firstParameter = valuesInHSBA.alpha
            default:
                fatalError("Parameter \(parameters.0) not in colour space")
            }
            switch parameters.1 {
            case .hue:
                return (firstParameter, valuesInHSBA.hue)
            case .saturation:
                return (firstParameter, valuesInHSBA.saturation)
            case .brightness:
                return (firstParameter, valuesInHSBA.brightness)
            case .alpha:
                return (firstParameter, valuesInHSBA.alpha)
            default:
                fatalError("Parameter \(parameters.1) not in colour space")
            }
        } else if let valuesInCMYKA = _$values as? Binding<ColourModel.CMYKAValues> {
            var firstParameter: Binding<Double>
            switch parameters.0 {
            case .cyan:
                firstParameter = valuesInCMYKA.cyan
            case .magenta:
                firstParameter = valuesInCMYKA.magenta
            case .yellow:
                firstParameter = valuesInCMYKA.yellow
            case .black:
                firstParameter = valuesInCMYKA.black
            case .alpha:
                firstParameter = valuesInCMYKA.alpha
            default:
                fatalError("Parameter \(parameters.0) not in colour space")
            }
            switch parameters.1 {
            case .cyan:
                return (firstParameter, valuesInCMYKA.cyan)
            case .magenta:
                return (firstParameter, valuesInCMYKA.magenta)
            case .yellow:
                return (firstParameter, valuesInCMYKA.yellow)
            case .black:
                return (firstParameter, valuesInCMYKA.black)
            case .alpha:
                return (firstParameter, valuesInCMYKA.alpha)
            default:
                fatalError("Parameter \(parameters.1) not in colour space")
            }
        } else {
            fatalError("Could not find a colour space for values")
        }
    }
}
