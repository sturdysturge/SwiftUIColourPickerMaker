//
//  WheelDataStorable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol WheelDataStorable {
  func getBindingValue(for: Parameter) -> Binding<Double>
  associatedtype ValueType
  var values: ValueType { get }
  var _$values: Binding<ValueType> { get }
  var angularGradient: Gradient { get }
  var radialGradient: Gradient { get }
  var rotation: Parameter { get }
  var distanceFromCentre: Parameter { get }
  func getHue() -> Double?
}

struct HSBWheelData: WheelDataStorable {
  init(rotation: Parameter, distanceFromCentre: Parameter, values: Binding<ValueType>) {
    self.angularGradient = rotation.gradient
    self.radialGradient = distanceFromCentre.gradient
    self.rotation = rotation
    self.distanceFromCentre = distanceFromCentre
    self._values = values
  }
  
  let angularGradient: Gradient
  let radialGradient: Gradient
  let rotation: Parameter
  let distanceFromCentre: Parameter
    typealias ValueType = ColourModel.HSBAValues
    var _$values: Binding<ValueType> { _values }
    @Binding var values: ValueType
}

struct RGBWheelData: WheelDataStorable {
  init(rotation: Parameter, distanceFromCentre: Parameter, values: Binding<ValueType>) {
    self.angularGradient = rotation.gradient
    self.radialGradient = distanceFromCentre.gradient
    self.rotation = rotation
    self.distanceFromCentre = distanceFromCentre
    self._values = values
  }
  let angularGradient: Gradient
  let radialGradient: Gradient
  let rotation: Parameter
  let distanceFromCentre: Parameter
    typealias ValueType = ColourModel.RGBAValues
    var _$values: Binding<ValueType> { _values }
    @Binding var values: ValueType
}

struct CMYKWheelData: WheelDataStorable {
  init(rotation: Parameter, distanceFromCentre: Parameter, values: Binding<ValueType>) {
    self.angularGradient = rotation.gradient
    self.radialGradient = distanceFromCentre.gradient
    self.rotation = rotation
    self.distanceFromCentre = distanceFromCentre
    self._values = values
  }
  let angularGradient: Gradient
  let radialGradient: Gradient
  let rotation: Parameter
  let distanceFromCentre: Parameter
    typealias ValueType = ColourModel.CMYKAValues
    var _$values: Binding<ValueType> { _values }
    @Binding var values: ValueType
}

extension WheelDataStorable where ValueType == ColourModel.HSBAValues {
  func  getBindingValue(for parameter: Parameter) -> Binding<Double> {
    switch parameter {
      case .hue: return _$values.hue
    case .saturation: return _$values.saturation
    case .brightness: return _$values.brightness
    case .alpha: return _$values.alpha
    default: fatalError("Parameter \(parameter) was not expected in colour space")
    }
  }
}

extension WheelDataStorable where ValueType == ColourModel.CMYKAValues {
  func  getBindingValue(for parameter: Parameter) -> Binding<Double> {
    switch parameter {
      case .cyan: return _$values.cyan
    case .magenta: return _$values.magenta
    case .yellow: return _$values.yellow
    case .black: return _$values.black
    case .alpha: return _$values.alpha
    default: fatalError("Parameter \(parameter) was not expected in colour space")
    }
  }
}

extension WheelDataStorable where ValueType == ColourModel.RGBAValues {
  func  getBindingValue(for parameter: Parameter) -> Binding<Double> {
    switch parameter {
      case .red: return _$values.red
    case .green: return _$values.green
    case .blue: return _$values.blue
    case .alpha: return _$values.alpha
    default: fatalError("Parameter \(parameter) was not expected in colour space")
    }
  }
}

extension WheelDataStorable {
  func getHue() -> Double? {
    if let values = values as? ColourModel.HSBAValues {
      return values.hue
    }
    else {
      return nil
    }
  }
}
