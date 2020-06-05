//
//  PaletteData.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct PaletteData<T>: PaletteDataStorable {
    typealias ValueType = T
    @Binding var values: ValueType
    var _$values: Binding<ValueType> { _values }
    let parameters: (Parameter, Parameter)
    let size: (rows: Int, columns: Int)
}
