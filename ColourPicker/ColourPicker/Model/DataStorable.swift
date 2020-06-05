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
  var bindingValues: (x: Binding<Double>, y: Binding<Double>) { get }
  var parameters: (Parameter, Parameter) { get }
  func getHue() -> Double?
  func getConstant(from values: ValueType, for parameter: Parameter) -> Double
}

extension DataStorable {
  func getHue() -> Double? {
    if let values = values as? ColourModel.HSBAValues {
      return values.hue
    } else {
      return nil
    }
  }
  
  /// Get a specific parameter from a generic values tuple
  /// - Parameters:
  ///   - parameter: The parameter in the same colour space
  /// - Returns: A constant Double value for that parameter
  func getConstant(from values: ValueType, for parameter: Parameter) -> Double {
    if let valuesInRGBA = values as? ColourModel.RGBAValues {
      switch parameter {
      case .red:
        return valuesInRGBA.red
      case .green:
        return valuesInRGBA.green
      case .blue:
        return valuesInRGBA.blue
      case .alpha:
        return valuesInRGBA.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
      }
    } else if let valuesInHSBA = values as? ColourModel.HSBAValues {
      switch parameter {
      case .hue:
        return valuesInHSBA.hue
      case .green:
        return valuesInHSBA.saturation
      case .brightness:
        return valuesInHSBA.brightness
      case .alpha:
        return valuesInHSBA.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
      }
    } else if let valuesInCMYKA = values as? ColourModel.CMYKAValues {
      switch parameter {
      case .cyan:
        return valuesInCMYKA.cyan
      case .magenta:
        return valuesInCMYKA.magenta
      case .yellow:
        return valuesInCMYKA.yellow
      case .black:
        return valuesInCMYKA.black
      case .alpha:
        return valuesInCMYKA.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
      }
    } else if let valuesInGreyscale = values as? ColourModel.GreyscaleValues {
      switch parameter {
      case .white:
        return valuesInGreyscale.white
      case .alpha:
        return valuesInGreyscale.alpha
      default:
        fatalError("Parameter \(parameter) not in colour space")
      }
    }
    else {
      fatalError("Unknown type")
    }
  }
  
  var bindingValues: (x: Binding<Double>, y: Binding<Double>) {
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
    } else if let valuesInGreyscale = _$values as? Binding<ColourModel.GreyscaleValues> {
      if parameters.0 == .white && parameters.1 == .alpha {
        return (valuesInGreyscale.white, valuesInGreyscale.alpha)
      }
      else if parameters.0 == .alpha && parameters.1 == .white {
        return (valuesInGreyscale.alpha, valuesInGreyscale.white)
      }
      else {
        fatalError("Parameter \(parameters.1) not in colour space")
      }
    }
    
    else {
      fatalError("Could not find a colour space for values")
    }
  }
}
