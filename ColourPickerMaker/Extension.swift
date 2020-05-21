//
//  Extension.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 21/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

extension Color {
  static let indigo = Color(red: 0.29, green: 0, blue: 0.5)
  static let violet = Color(red: 0.93, green: 0.5, blue: 0.93)
  static let background = Color(UIColor.systemBackground)
}

extension Axis {
  var start: UnitPoint {
    switch self {
    case .horizontal:
      return .leading
    case .vertical:
      return .top
    }
  }
  
  var end: UnitPoint {
    switch self {
    case .horizontal:
      return .trailing
    case .vertical:
      return .bottom
    }
  }
}

extension View {
  func horizontalDrag(value: Binding<Double>, width: CGFloat) -> some View {
    return modifier(HorizontalSlider(value: value, width: width))
  }
  
  func bidirectionalDrag(xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) -> some View {
    return modifier(BidirectionalSlider(xValue: xValue, yValue: yValue, size: size))
  }
}

extension LinearGradient {
  
  static func fromColours(_ colours: [Color], axis: Axis) -> LinearGradient {
    return LinearGradient(gradient: Gradient(colors: colours), startPoint: axis.start, endPoint: axis.end)
  }
  
  
  static func brightnessOverlay(axis: Axis) -> LinearGradient {
    let startPoint = axis == .horizontal ? UnitPoint.leading : UnitPoint.top
    let endPoint = axis == .horizontal ? UnitPoint.trailing : UnitPoint.bottom
    return LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: startPoint, endPoint: endPoint)
  }
  static func saturationOverlay(axis: Axis) -> LinearGradient {
    let startPoint = axis == .horizontal ? UnitPoint.leading : UnitPoint.top
    let endPoint = axis == .horizontal ? UnitPoint.trailing : UnitPoint.bottom
    return LinearGradient(gradient: Gradient(colors: [.white, Color(.sRGBLinear, white: 1, opacity: 0.6), Color(.sRGBLinear, white: 1, opacity: 0.3), .clear]), startPoint: startPoint, endPoint: endPoint)
  }
  static func hue(axis: Axis) -> LinearGradient {
    let startPoint = axis == .horizontal ? UnitPoint.leading : UnitPoint.top
    let endPoint = axis == .horizontal ? UnitPoint.trailing : UnitPoint.bottom
    return LinearGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .indigo, .violet, .red]), startPoint: startPoint, endPoint: endPoint)
  }
  
  static func alpha(axis: Axis) -> LinearGradient {
    let startPoint = axis == .horizontal ? UnitPoint.trailing : UnitPoint.bottom
    let endPoint = axis == .horizontal ? UnitPoint.leading : UnitPoint.top
    return LinearGradient(gradient: Gradient(colors: [.white, Color(.sRGBLinear, white: 1, opacity: 0.9), Color(.sRGBLinear, white: 1, opacity: 0.5)]), startPoint: startPoint, endPoint: endPoint)
  }
  
  static func brightness(hue: Double, axis: Axis) -> LinearGradient {
    let startPoint = axis == .horizontal ? UnitPoint.leading : UnitPoint.top
    let endPoint = axis == .horizontal ? UnitPoint.trailing : UnitPoint.bottom
    return LinearGradient(gradient: Gradient(colors: [Color(hue: hue, saturation: 1, brightness: 0), Color(hue: hue, saturation: 1, brightness: 1)]), startPoint: startPoint, endPoint: endPoint)
  }
  
  static func saturation(hue: Double, axis: Axis) -> LinearGradient {
    let startPoint = axis == .horizontal ? UnitPoint.leading : UnitPoint.top
    let endPoint = axis == .horizontal ? UnitPoint.trailing : UnitPoint.bottom
    return LinearGradient(gradient: Gradient(colors: [.white, Color(hue: hue, saturation: 1, brightness: 1)]), startPoint: startPoint, endPoint: endPoint)
  }
}
