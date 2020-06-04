//
//  CanvasData.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct CanvasData<T>: DataStorable {
    var parameters: (Parameter, Parameter)
    typealias ValueType = T
    @Binding var values: ValueType
    var _$values: Binding<ValueType> { _values }
}
