//
//  SliderView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
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
  func getLinearGradient() -> LinearGradient
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
  
  func getLinearGradient() -> LinearGradient {
    var startColour = values
    var endColour = values
    switch parameter {
    case .red:
      startColour.red = 0
      endColour.red = 1
    case .green:
      startColour.green = 0
      endColour.green = 1
    case .blue:
      startColour.blue = 0
      endColour.blue = 1
    case .alpha:
      startColour.alpha = 0
      endColour.alpha = 1
    default:
      fatalError("Parameter \(parameter) not in colour space")
    }
    return Gradient(colors: [Color.fromValues(startColour), Color.fromValues(endColour)]).linearGradient(orientation)
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
  
  func getLinearGradient() -> LinearGradient {
    var startColour = values
    var endColour = values
    switch parameter {
    case .hue:
      return Gradient.hue.linearGradient(orientation)
    case .saturation:
      startColour.saturation = 0
      endColour.saturation = 1
    case .brightness:
      startColour.brightness = 0
      endColour.brightness = 1
    case .alpha:
      startColour.alpha = 0
      endColour.alpha = 1
    default:
      fatalError("Parameter \(parameter) not in colour space")
    }
    return Gradient(colors: [Color.fromValues(startColour), Color.fromValues(endColour)]).linearGradient(orientation)
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
  
  func getLinearGradient() -> LinearGradient {
    var startColour = values
    var endColour = values
    switch parameter {
    case .cyan:
      startColour.cyan = 0
      endColour.cyan = 1
    case .magenta:
      startColour.magenta = 0
      endColour.magenta = 1
    case .yellow:
      startColour.yellow = 0
      endColour.yellow = 1
    case .black:
      startColour.black = 0
      endColour.black = 1
    case .alpha:
      startColour.alpha = 0
      endColour.alpha = 1
    default:
      fatalError("Parameter \(parameter) not in colour space")
    }
    return Gradient(colors: [Color.fromValues(startColour), Color.fromValues(endColour)]).linearGradient(orientation)
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
  func getLinearGradient() -> LinearGradient {
    var startColour = values
    var endColour = values
    switch parameter {
    case .white:
      startColour.white = 0
      endColour.white = 1
    case .alpha:
      startColour.alpha = 0
      endColour.alpha = 1
    default:
      fatalError("Parameter \(parameter) not in colour space")
    }
    return Gradient(colors: [Color.fromValues(startColour), Color.fromValues(endColour)]).linearGradient(orientation)
    
  }
}

struct RGBASliderData: SliderDataBindable {
  typealias ValueType = ColourModel.RGBAValues
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  let parameter: Parameter
  let orientation: Axis
}

struct HSBASliderData: SliderDataBindable {
  typealias ValueType = ColourModel.HSBAValues
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  let parameter: Parameter
  let orientation: Axis
}

struct CMYKASliderData: SliderDataBindable {
  typealias ValueType = ColourModel.CMYKAValues
  @Binding var values: ValueType
  var _$values: Binding<ValueType> { _values }
  let parameter: Parameter
  let orientation: Axis
}

struct GreyscaleSliderData: SliderDataBindable {
  typealias ValueType = ColourModel.GreyscaleValues
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
