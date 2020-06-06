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
  var hue: Double? { get }
  /// Get a specific parameter from a generic values tuple
  /// - Parameters:
  ///   - parameter: The parameter in the same colour space
  /// - Returns: A constant Double value for that parameter
  func getConstant(from values: ValueType, for parameter: Parameter) -> Double
}

struct RGBAData: DataStorable {
  typealias ValueType = ColourModel.RGBAValues
  var hue: Double? = nil
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  var bindingValues: (x: Binding<Double>, y: Binding<Double>)
  var parameters: (Parameter, Parameter)
}

struct HSBAData: DataStorable {
  typealias ValueType = ColourModel.HSBAValues
  var hue: Double? {
    return values.hue
  }
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  var bindingValues: (x: Binding<Double>, y: Binding<Double>)
  var parameters: (Parameter, Parameter)
}

struct CMYKAData: DataStorable {
  typealias ValueType = ColourModel.CMYKAValues
  var hue: Double? = nil
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  var bindingValues: (x: Binding<Double>, y: Binding<Double>)
  var parameters: (Parameter, Parameter)
}

struct GreyscaleData: DataStorable {
  typealias ValueType = ColourModel.GreyscaleValues
  var hue: Double? = nil
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  var bindingValues: (x: Binding<Double>, y: Binding<Double>)
  var parameters: (Parameter, Parameter)
}

extension DataStorable where ValueType == ColourModel.RGBAValues {
  func getConstant(from values: ValueType, for parameter: Parameter) -> Double {
    switch parameter {
    case .red:
      return values.red
    case .green:
      return values.green
    case .blue:
      return values.blue
    case .alpha:
      return values.alpha
    default: fatalError("Parameter \(parameter) not in colour space")
  }
}
  
  var bindingValues: (x: Binding<Double>, y: Binding<Double>) {
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

extension DataStorable where ValueType == ColourModel.HSBAValues {
  func getConstant(from values: ValueType, for parameter: Parameter) -> Double {
    switch parameter {
    case .hue:
      return values.hue
    case .green:
      return values.saturation
    case .brightness:
      return values.brightness
    case .alpha:
      return values.alpha
    default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
  
  var bindingValues: (x: Binding<Double>, y: Binding<Double>) {
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

extension DataStorable where ValueType == ColourModel.CMYKAValues {
  func getConstant(from values: ValueType, for parameter: Parameter) -> Double {
      switch parameter {
      case .cyan:
        return values.cyan
      case .magenta:
        return values.magenta
      case .yellow:
        return values.yellow
      case .black:
        return values.black
      case .alpha:
        return values.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
      }
    }
  
  var bindingValues: (x: Binding<Double>, y: Binding<Double>) {
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

extension DataStorable where ValueType == ColourModel.GreyscaleValues {
func getConstant(from values: ValueType, for parameter: Parameter) -> Double {
      switch parameter {
      case .white:
        return values.white
      case .alpha:
        return values.alpha
      default:
        fatalError("Parameter \(parameter) not in colour space")
      }
    }
  
  var bindingValues: (x: Binding<Double>, y: Binding<Double>) {
    if parameters.0 == .white && parameters.1 == .alpha {
      return (_$values.white, _$values.alpha)
    }
    else if parameters.0 == .alpha && parameters.1 == .white {
      return (_$values.alpha, _$values.white)
    }
    else {
      fatalError("Parameter \(parameters.1) not in colour space")
    }
  }
}
