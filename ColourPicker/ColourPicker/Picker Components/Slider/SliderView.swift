//
//  SliderView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI


struct RGBASliderData: SliderDataBindable {
  init(values: Binding<ValueType>, parameter: Parameter, orientation: Axis) {
    self.parameter = parameter
    self.orientation = orientation
    self._values = values
    self.linearGradient = Gradient.fromValues(values.wrappedValue, parameter: parameter).linearGradient(orientation)
  }
  typealias ValueType = ColourModel.RGBAValues
  let linearGradient: LinearGradient
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  let parameter: Parameter
  let orientation: Axis
}

struct HSBASliderData: SliderDataBindable {
init(values: Binding<ValueType>, parameter: Parameter, orientation: Axis) {
  self.parameter = parameter
  self.orientation = orientation
  self._values = values
  self.linearGradient = Gradient.fromValues(values.wrappedValue, parameter: parameter).linearGradient(orientation)
}
  typealias ValueType = ColourModel.HSBAValues
  let linearGradient: LinearGradient
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  let parameter: Parameter
  let orientation: Axis
}

struct CMYKASliderData: SliderDataBindable {
init(values: Binding<ValueType>, parameter: Parameter, orientation: Axis) {
  self.parameter = parameter
  self.orientation = orientation
  self._values = values
  self.linearGradient = Gradient.fromValues(values.wrappedValue, parameter: parameter).linearGradient(orientation)
}
  typealias ValueType = ColourModel.CMYKAValues
  let linearGradient: LinearGradient
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  let parameter: Parameter
  let orientation: Axis
}

struct GreyscaleSliderData: SliderDataBindable {
init(values: Binding<ValueType>, parameter: Parameter, orientation: Axis) {
  self.parameter = parameter
  self.orientation = orientation
  self._values = values
  self.linearGradient = Gradient.fromValues(values.wrappedValue, parameter: parameter).linearGradient(orientation)
}
  typealias ValueType = ColourModel.GreyscaleValues
  let linearGradient: LinearGradient
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  let parameter: Parameter
  let orientation: Axis
}

struct RGBASliderView: SliderPickable {
  typealias DataType = RGBASliderData
  let data: DataType
  @State var thumbOffset = CGPoint()
  var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
  let thickness: CGFloat
  let length: CGFloat
}

struct HSBASliderView: SliderPickable {
  typealias DataType = HSBASliderData
  let data: DataType
  @State var thumbOffset = CGPoint()
  var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
  let thickness: CGFloat
  let length: CGFloat
}

struct CMYKASliderView: SliderPickable {
  typealias DataType = CMYKASliderData
  let data: DataType
  @State var thumbOffset = CGPoint()
  var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
  let thickness: CGFloat
  let length: CGFloat
}

struct GreyscaleSliderView: SliderPickable {
  typealias DataType = GreyscaleSliderData
  let data: DataType
  @State var thumbOffset = CGPoint()
  var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
  let thickness: CGFloat
  let length: CGFloat
}

struct SliderView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView_Previews.previews
  }
}
