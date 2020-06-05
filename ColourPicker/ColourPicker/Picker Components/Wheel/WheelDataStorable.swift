//
//  WheelDataStorable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol WheelDataStorable: DataStorable {
  var angularGradient: Gradient { get }
  var radialGradient: Gradient { get }
}

struct WheelData<T>: WheelDataStorable {
  typealias ValueType = T
  var parameters: (Parameter, Parameter)
  @Binding var values: ValueType
  var _$values: Binding<T> { _values }
  let angularGradient: Gradient
  let radialGradient: Gradient
  
  init(rotation: Parameter, distanceFromCentre: Parameter, values: Binding<ValueType>) {
    angularGradient = rotation.gradient
    radialGradient = distanceFromCentre.gradient
    parameters = (rotation, distanceFromCentre)
    _values = values
  }
  
  
}
