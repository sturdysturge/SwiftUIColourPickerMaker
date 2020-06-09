//  SliderDataBindable.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

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

public struct RGBASliderData: SliderDataBindable {
    public init(values: Binding<ValueType>, parameter: Parameter, orientation: Axis) {
        self.parameter = parameter
        self.orientation = orientation
        _values = values
        linearGradient = Gradient.fromValues(values.wrappedValue, parameter: parameter).linearGradient(orientation)
    }

    public typealias ValueType = ColourModel.RGBAValues
    let linearGradient: LinearGradient
    @Binding var values: ValueType
    var _$values: Binding<ValueType> { _values }
    let parameter: Parameter
    let orientation: Axis
}

public struct HSBASliderData: SliderDataBindable {
    public init(values: Binding<ValueType>, parameter: Parameter, orientation: Axis) {
        self.parameter = parameter
        self.orientation = orientation
        _values = values
        linearGradient = Gradient.fromValues(values.wrappedValue, parameter: parameter).linearGradient(orientation)
    }

    public typealias ValueType = ColourModel.HSBAValues
    let linearGradient: LinearGradient
    @Binding var values: ValueType
    var _$values: Binding<ValueType> { _values }
    let parameter: Parameter
    let orientation: Axis
}

public struct CMYKASliderData: SliderDataBindable {
    public init(values: Binding<ValueType>, parameter: Parameter, orientation: Axis) {
        self.parameter = parameter
        self.orientation = orientation
        _values = values
        linearGradient = Gradient.fromValues(values.wrappedValue, parameter: parameter).linearGradient(orientation)
    }

    public typealias ValueType = ColourModel.CMYKAValues
    let linearGradient: LinearGradient
    @Binding var values: ValueType
    var _$values: Binding<ValueType> { _values }
    let parameter: Parameter
    let orientation: Axis
}

public struct GreyscaleSliderData: SliderDataBindable {
    public init(values: Binding<ValueType>, parameter: Parameter, orientation: Axis) {
        self.parameter = parameter
        self.orientation = orientation
        _values = values
        linearGradient = Gradient.fromValues(values.wrappedValue, parameter: parameter).linearGradient(orientation)
    }

    public typealias ValueType = ColourModel.GreyscaleValues
    let linearGradient: LinearGradient
    @Binding var values: ValueType
    var _$values: Binding<ValueType> { _values }
    let parameter: Parameter
    let orientation: Axis
}
