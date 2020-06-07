//
//  SliderDataBindable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 07/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol SliderDataBindable {
  associatedtype ValueType
  var values: ValueType { get }
  var _$values: Binding<ValueType> { get }
  var parameter: Parameter { get }
  var orientation: Axis { get }
  func getBindingValue() -> Binding<Double>
  var linearGradient: LinearGradient { get }
}


extension SliderDataBindable where ValueType == ColourModel.RGBAValues {
  func getBindingValue() -> Binding<Double> {
    switch parameter {
    case .red:
      return _$values.red
    case .green:
      return _$values.green
    case .blue:
      return _$values.blue
    case .alpha:
      return _$values.alpha
    default:
      fatalError("Parameter \(parameter) not in colour space")
    }
  }
}

extension SliderDataBindable where ValueType == ColourModel.HSBAValues {
  func getBindingValue() -> Binding<Double> {
    switch parameter {
    case .hue:
      return _$values.hue
    case .saturation:
      return _$values.saturation
    case .brightness:
      return _$values.brightness
    case .alpha:
      return _$values.alpha
    default:
      fatalError("Parameter \(parameter) not in colour space")
    }
  }
}

extension SliderDataBindable where ValueType == ColourModel.CMYKAValues {
  
  func getBindingValue() -> Binding<Double> {
    switch parameter {
    case .cyan:
      return _$values.cyan
    case .magenta:
      return _$values.magenta
    case .yellow:
      return _$values.yellow
    case .black:
      return _$values.black
    case .alpha:
      return _$values.alpha
    default:
      fatalError("Parameter \(parameter) not in colour space")
    }
  }
}

extension SliderDataBindable where ValueType == ColourModel.GreyscaleValues {
  func getBindingValue() -> Binding<Double> {
    switch parameter {
    case .white:
      return _$values.white
    case .alpha:
      return _$values.alpha
    default:
      fatalError("Parameter \(parameter) not in colour space")
    }
  }
}
