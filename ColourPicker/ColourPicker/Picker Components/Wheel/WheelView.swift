//
//  WheelView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct WheelView<T>: View, WheelPickable where T: WheelDataStorable {
  typealias ValueType = T
  
  internal init(data: T) {
    self.data = data
    let parameters = [data.rotation, data.distanceFromCentre]
    if parameters.contains(.brightness) {
      if parameters.contains(.saturation) {
        self.backgroundColour = .clear
      }
      else {
        self.backgroundColour = .black
      }
      }
      else if parameters.contains(.saturation) {
        self.backgroundColour = .white
      }
    else {
      self.backgroundColour = .clear
    }
    self._rotation = data.getBindingValue(for: data.rotation)
    self._distanceFromCentre = data.getBindingValue(for: data.distanceFromCentre)
  }
  
  
  let backgroundColour: Color
  let data: ValueType
  
  @Binding var rotation: Double
  @Binding var distanceFromCentre: Double
  @State var thumbOffset = CGPoint()
  var _$rotation: Binding<Double> { _rotation }
  var _$distanceFromCentre: Binding<Double> { _distanceFromCentre }
  var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
}

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

protocol WheelPickable {
  associatedtype ValueType where ValueType: WheelDataStorable
  var data: ValueType { get }
  var rotation: Double { get }
  var _$rotation: Binding<Double> { get }
  var distanceFromCentre: Double { get }
  var _$distanceFromCentre: Binding<Double> { get }
  var thumbOffset: CGPoint { get }
  var _$thumbOffset: Binding<CGPoint> { get }
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

extension WheelPickable where Self: View {
  var body: some View {
    ZStack {
      Color(hue: self.data.getHue() ?? 0, saturation: 1, brightness: 1, opacity: self.data.getHue() ?? 0)
        .clipShape(Circle())
      GeometryReader { geometry in
        CircleGradientView(angularGradient: self.data.angularGradient, radialGradient: self.data.radialGradient, radius: geometry.size.width * 0.7)
          .radialDrag(rotation: self._$rotation, distanceFromCentre: self._$distanceFromCentre, size: geometry.size, offset: self._$thumbOffset)
        Group {
          CircleThumbView()
            .frame(width: 25, height: 25)
            .offset(x: self.thumbOffset.x, y: self.thumbOffset.y)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      }
    }
    .aspectRatio(1, contentMode: .fit)
  }
}



struct WheelView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}



