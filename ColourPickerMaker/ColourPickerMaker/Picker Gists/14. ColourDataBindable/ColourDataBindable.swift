//  ColourDataBindable.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

protocol ColourDataBindable {
    associatedtype ValueType
    var values: ValueType { get }
    var _$values: Binding<ValueType> { get }
    func bindingValues() -> (x: Binding<Double>, y: Binding<Double>)
    var parameters: Parameter.Pair { get }
    func getBackground() -> Color
}

struct RGBAData: ColourDataBindable {
    typealias ValueType = ColourModel.RGBAValues
    @Binding var values: ValueType
    var _$values: Binding<ValueType> { _values }
    let parameters: Parameter.Pair
}

struct HSBAData: ColourDataBindable {
    typealias ValueType = ColourModel.HSBAValues
    @Binding var values: ValueType
    var _$values: Binding<ValueType> { _values }
    let parameters: Parameter.Pair
}

struct CMYKAData: ColourDataBindable {
    typealias ValueType = ColourModel.CMYKAValues
    @Binding var values: ValueType
    var _$values: Binding<ValueType> { _values }
    let parameters: Parameter.Pair
}

struct GreyscaleData: ColourDataBindable {
    typealias ValueType = ColourModel.GreyscaleValues
    @Binding var values: ValueType
    var _$values: Binding<ValueType> { _values }
    let parameters: Parameter.Pair
}