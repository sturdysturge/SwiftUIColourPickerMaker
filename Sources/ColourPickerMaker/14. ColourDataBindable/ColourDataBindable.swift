//  ColourDataBindable.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

public protocol ColourDataBindable {
  associatedtype ValueType
  var values: ValueType { get }
  var _$values: Binding<ValueType> { get }
  func bindingValues() -> (x: Binding<Double>, y: Binding<Double>)
  var parameters: Parameter.Pair { get }
  func getBackground() -> Color
}

public struct RGBAData: ColourDataBindable {
  public typealias ValueType = ColourModel.RGBAValues
  @Binding public var values: ValueType
  public var _$values: Binding<ValueType> { _values }
  public let parameters: Parameter.Pair
  
  public init(values: Binding<ValueType>, parameters: Parameter.Pair) {
    self._values = values
    self.parameters = parameters
  }
}

public struct HSBAData: ColourDataBindable {
  public typealias ValueType = ColourModel.HSBAValues
  @Binding public var values: ValueType
  public var _$values: Binding<ValueType> { _values }
  public let parameters: Parameter.Pair
  
  public init(values: Binding<ValueType>, parameters: Parameter.Pair) {
    self._values = values
    self.parameters = parameters
  }
}

public struct CMYKAData: ColourDataBindable {
  public typealias ValueType = ColourModel.CMYKAValues
  @Binding public var values: ValueType
  public var _$values: Binding<ValueType> { _values }
  public let parameters: Parameter.Pair
  
  public init(values: Binding<ValueType>, parameters: Parameter.Pair) {
    self._values = values
    self.parameters = parameters
  }
}

public struct GreyscaleData: ColourDataBindable {
  
  public typealias ValueType = ColourModel.GreyscaleValues
  @Binding public var values: ValueType
  public var _$values: Binding<ValueType> { _values }
  public let parameters: Parameter.Pair
  
  public init(values: Binding<ValueType>, parameters: Parameter.Pair) {
    self._values = values
    self.parameters = parameters
  }
}
