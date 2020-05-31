//
//  PaletteView2.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI


extension ColourDataStorable {
  
  func getValueFor(_ parameter: Parameter, xIndex: Int, yIndex: Int) -> Double {
    if horizontal == parameter {
      return Double(xIndex) / Double(horizontalSwatches - 1)
    }
    else if vertical == parameter {
      return Double(yIndex) / Double(verticalSwatches - 1)
    }
    else {
      return getParameterFromConstants(parameter)
    }
  }
  
}

extension ColourDataStorable {
  func getSwatchColour(values: ValueType) -> Color {
    return Color.clear
  }
  
  func getSwatch(xIndex: Int, yIndex: Int) -> ValueType {
    return constants
  }
  
  func getSwatchParameter(_ axis: Axis, swatch: ValueType) -> Double {
    return 0
  }
  
  func getParameterFromConstants(_ parameter: Parameter) -> Double {
    return 0
  }
}

extension ColourDataStorable where ValueType == ColourModel.RGBAValues {
  func getSwatchColour(values: ColourModel.RGBAValues) -> Color {
    return Color.fromValues(values)
  }
  
  func getSwatch(xIndex: Int, yIndex: Int) -> ValueType {
    return (red: getValueFor(.red, xIndex: xIndex, yIndex: yIndex), green: getValueFor(.green, xIndex: xIndex, yIndex: yIndex), blue: getValueFor(.blue, xIndex: xIndex, yIndex: yIndex), alpha: getValueFor(.alpha, xIndex: xIndex, yIndex: yIndex))
  }
  
  func getSwatchParameter(_ axis: Axis, swatch: ValueType) -> Double {
    let parameter = axis == .horizontal ? horizontal : vertical
    switch parameter {
      case .red: return swatch.red
      case .green: return swatch.green
      case .blue: return swatch.blue
      case .alpha: return swatch.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
  
  func getParameterFromConstants(_ parameter: Parameter) -> Double {
    switch parameter {
    case .red: return constants.red
    case .green: return constants.green
    case .blue: return constants.blue
    case .alpha: return constants.alpha
    default: fatalError("Parameter \(parameter) not in colour space")
  }
  }
}

extension ColourDataStorable where ValueType == ColourModel.HSBAValues {
  func getSwatchColour(values: ColourModel.HSBAValues) -> Color {
    return Color.fromValues(values)
  }
  
  func getSwatch(xIndex: Int, yIndex: Int) -> ValueType {
    return (hue: getValueFor(.hue, xIndex: xIndex, yIndex: yIndex), saturation: getValueFor(.saturation, xIndex: xIndex, yIndex: yIndex), brightness: getValueFor(.brightness, xIndex: xIndex, yIndex: yIndex), alpha: getValueFor(.alpha, xIndex: xIndex, yIndex: yIndex))
  }
  
  func getSwatchParameter(_ axis: Axis, swatch: ValueType) -> Double {
    let parameter = axis == .horizontal ? horizontal : vertical
    switch parameter {
      case .hue: return swatch.hue
      case .saturation: return swatch.saturation
      case .brightness: return swatch.brightness
      case .alpha: return swatch.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
  
  func getParameterFromConstants(_ parameter: Parameter) -> Double {
    switch parameter {
    case .hue: return constants.hue
    case .green: return constants.saturation
    case .brightness: return constants.brightness
    case .alpha: return constants.alpha
    default: fatalError("Parameter \(parameter) not in colour space")
  }
  }
}

extension ColourDataStorable where ValueType == ColourModel.CMYKAValues {
  func getSwatchColour(values: ColourModel.CMYKAValues) -> Color {
    return Color.fromValues(values)
  }
  
  func getSwatch(xIndex: Int, yIndex: Int) -> ValueType {
    return (cyan: getValueFor(.cyan, xIndex: xIndex, yIndex: yIndex), magenta: getValueFor(.magenta, xIndex: xIndex, yIndex: yIndex), yellow: getValueFor(.yellow, xIndex: xIndex, yIndex: yIndex), black: getValueFor(.black, xIndex: xIndex, yIndex: yIndex), alpha: getValueFor(.alpha, xIndex: xIndex, yIndex: yIndex))
  }
  
  func getSwatchParameter(_ axis: Axis, swatch: ValueType) -> Double {
    let parameter = axis == .horizontal ? horizontal : vertical
    switch parameter {
      case .cyan: return swatch.cyan
      case .magenta: return swatch.magenta
      case .yellow: return swatch.yellow
    case .black: return swatch.black
      case .alpha: return swatch.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
  
  func getParameterFromConstants(_ parameter: Parameter) -> Double {
    switch parameter {
    case .cyan: return constants.cyan
      case .magenta: return constants.magenta
      case .yellow: return constants.yellow
    case .black: return constants.black
      case .alpha: return constants.alpha
    default: fatalError("Parameter \(parameter) not in colour space")
  }
  }
  
}

struct NewPalette<T>: View where T: ColourDataStorable {
  let data: T
  @Binding var xValue: Double
  @Binding var yValue: Double
  func setValues(xValue: Double, yValue: Double) {
    self.xValue = xValue
    self.yValue = yValue
  }
  var body: some View {
    VStack {
      ForEach(0 ..< data.verticalSwatches, id: \.self) {
        yIndex in
        HStack {
          ForEach(0 ..< self.data.horizontalSwatches, id: \.self) {
            xIndex in
            Button(action: {
              let swatch = self.data.getSwatch(xIndex: xIndex, yIndex: yIndex)
              self.setValues(xValue: self.data.getSwatchParameter(.horizontal, swatch: swatch), yValue:  self.data.getSwatchParameter(.vertical, swatch: swatch))
            }) {
              ZStack {
                TransparencyCheckerboardView()
                self.data.getSwatchColour(values: self.data.getSwatch(xIndex: xIndex, yIndex: yIndex))
              }
            }
          }
        }
      }
    }
  }
}

protocol ColourDataStorable {
  associatedtype ValueType
  func getSwatchColour(values: ValueType) -> Color
  func getSwatch(xIndex: Int, yIndex: Int) -> ValueType
  func getParameterFromConstants(_ parameter: Parameter) -> Double
  var constants: ValueType { get }
  var horizontal: Parameter { get }
  var vertical: Parameter { get }
  var horizontalSwatches: Int { get }
  var verticalSwatches: Int { get }
  func getSwatchParameter(_ axis: Axis, swatch: ValueType) -> Double
}



struct PaletteView2_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
