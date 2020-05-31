//
//  PaletteView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 30/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol PalettePickable {
  associatedtype values
  var horizontal: Parameter { get }
  var vertical: Parameter { get }
  var horizontalSwatches: Int { get }
  var verticalSwatches: Int { get }
  var constants: values { get }
  var swatches: [[values]] { get }
  func getSwatchParameter(_ axis: Axis, swatch: values) -> Double
  func getSwatchColour(values: values) -> Color
  func setValues(xValue: Double, yValue: Double)
  var xValue: Double { get set }
  var yValue: Double { get set }
}
 
extension PalettePickable where Self: View {
  
  var body: some View {
    VStack {
      ForEach(0 ..< verticalSwatches, id: \.self) {
        yIndex in
        HStack {
          ForEach(0 ..< self.horizontalSwatches, id: \.self) {
            xIndex in
            Button(action: {
              let swatch = self.swatches[yIndex][xIndex]
              self.setValues(xValue: self.getSwatchParameter(.horizontal, swatch: swatch), yValue:  self.getSwatchParameter(.vertical, swatch: swatch))
            }) {
              ZStack {
                TransparencyCheckerboardView()
                self.getSwatchColour(values: self.swatches[yIndex][xIndex])
              }
            }
          }
        }
      }
    }
  }
}

extension PalettePickable where values == ColourModel.RGBAValues {
  func getSwatchColour(values: ColourModel.RGBAValues) -> Color {
    return Color.fromValues(values)
  }
  
  func getSwatchParameter(_ axis: Axis, swatch: values) -> Double {
    let parameter = axis == .horizontal ? horizontal : vertical
    switch parameter {
      case .red: return swatch.red
      case .green: return swatch.green
      case .blue: return swatch.blue
      case .alpha: return swatch.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
  
  func getConstantForParameter(_ parameter: Parameter) -> Double {
    switch parameter {
    case .red: return constants.red
    case .green: return constants.green
    case .blue: return constants.blue
    case .alpha: return constants.alpha
    default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
}

extension PalettePickable where values == ColourModel.HSBAValues {
  func getSwatchColour(values: ColourModel.HSBAValues) -> Color {
    return Color.fromValues(values)
  }
  
  func getSwatchParameter(_ axis: Axis, swatch: values) -> Double {
    let parameter = axis == .horizontal ? horizontal : vertical
    switch parameter {
      case .hue: return swatch.hue
      case .saturation: return swatch.saturation
      case .brightness: return swatch.brightness
      case .alpha: return swatch.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
  
  func getConstantForParameter(_ parameter: Parameter) -> Double {
    switch parameter {
      case .hue: return constants.hue
      case .saturation: return constants.saturation
      case .brightness: return constants.brightness
      case .alpha: return constants.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
}

extension PalettePickable where values == ColourModel.CMYKAValues {
  func getSwatchColour(values: ColourModel.CMYKAValues) -> Color {
    return Color.fromValues(values)
  }
  func getConstantForParameter(_ parameter: Parameter) -> Double {
      switch parameter {
      case .cyan: return constants.cyan
      case .magenta: return constants.magenta
      case .yellow: return constants.yellow
      case .black: return constants.black
      case .alpha: return constants.alpha
      default: fatalError("Parameter \(parameter) not in colour space")
      }
  }
  
  func getSwatchParameter(_ axis: Axis, swatch: values) -> Double {
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
  
}

struct RGBAPaletteView: View, PalettePickable {
  func setValues(xValue: Double, yValue: Double) {
    self.xValue = xValue
    self.yValue = yValue
  }
  
  
  typealias values = ColourModel.RGBAValues
  @Binding var xValue: Double
  @Binding var yValue: Double
  let horizontal: Parameter
  let vertical: Parameter
  let constants: ColourModel.RGBAValues
  let horizontalSwatches: Int
  let verticalSwatches: Int
  let swatches: [[ColourModel.RGBAValues]]
  
  init(xValue: Binding<Double>, yValue: Binding<Double>, horizontal: Parameter, vertical: Parameter, constants: ColourModel.RGBAValues, horizontalSwatches: Int, verticalSwatches: Int) {
    self._xValue = xValue
    self._yValue = yValue
    self.horizontal = horizontal
    self.vertical = vertical
    self.constants = constants
    self.horizontalSwatches = horizontalSwatches
    self.verticalSwatches = verticalSwatches
    var colours = [[values]]()
    let getValueFor: (Parameter, Int, Int) -> Double = {
      parameter,xIndex,yIndex in
      if horizontal == parameter {
        return Double(xIndex) / Double(horizontalSwatches - 1)
      }
      else if vertical == parameter {
        return Double(yIndex) / Double(verticalSwatches - 1)
      }
      else {
        switch parameter {
        case .red: return constants.red
        case .green: return constants.green
        case .blue: return constants.blue
        case .alpha: return constants.alpha
        default: fatalError("Parameter \(parameter) not in colour space")
        }
      }
    }
    for yIndex in 0..<verticalSwatches {
      var row = [values]()
      for xIndex in 0..<horizontalSwatches {
        row.append((red: getValueFor(.red, xIndex, yIndex), green: getValueFor(.green, xIndex, yIndex), blue: getValueFor(.blue, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex)))
      }
      colours.append(row)
    }
    self.swatches = colours
  }
  
  
}

struct HSBAPaletteView: View, PalettePickable {
  func setValues(xValue: Double, yValue: Double) {
    self.xValue = xValue
    self.yValue = yValue
  }
  typealias values = ColourModel.HSBAValues
  
  @Binding var xValue: Double
  @Binding var yValue: Double
  let horizontal: Parameter
  let vertical: Parameter
  let constants: ColourModel.HSBAValues
  let horizontalSwatches: Int
  let verticalSwatches: Int
  var swatches: [[ColourModel.HSBAValues]]
  
  init(xValue: Binding<Double>, yValue: Binding<Double>, horizontal: Parameter, vertical: Parameter, constants: values, horizontalSwatches: Int, verticalSwatches: Int) {
    self._xValue = xValue
    self._yValue = yValue
    self.horizontal = horizontal
    self.vertical = vertical
    self.constants = constants
    self.horizontalSwatches = horizontalSwatches
    self.verticalSwatches = verticalSwatches
    var swatches = [[values]]()
    let getValueFor: ((Parameter, Int,  Int) -> Double) = {
      parameter, xIndex, yIndex in
      if horizontal == parameter {
        return Double(xIndex) / Double(horizontalSwatches - 1)
      }
      else if vertical == parameter {
        return Double(yIndex) / Double(verticalSwatches - 1)
      }
      else {
        switch parameter {
          case .hue: return constants.hue
          case .saturation: return constants.saturation
          case .brightness: return constants.brightness
          case .alpha: return constants.alpha
          default: fatalError("Parameter \(parameter) not in colour space")
        }
      }
    }
    for yIndex in 0..<verticalSwatches {
      var row = [values]()
      for xIndex in 0..<horizontalSwatches {
        row.append((hue: getValueFor(.hue, xIndex, yIndex), saturation: getValueFor(.saturation, xIndex, yIndex), brightness: getValueFor(.brightness, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex)))
      }
      swatches.append(row)
    }
    self.swatches = swatches
  }
}

struct CMYKAPaletteView: View, PalettePickable {
  
  func setValues(xValue: Double, yValue: Double) {
    self.xValue = xValue
    self.yValue = yValue
  }
  
  typealias values = ColourModel.CMYKAValues
  @Binding var xValue: Double
  @Binding var yValue: Double
  let horizontal: Parameter
  let vertical: Parameter
  let constants: ColourModel.CMYKAValues
  let horizontalSwatches: Int
  let verticalSwatches: Int
  var swatches: [[ColourModel.CMYKAValues]]
  
  init(xValue: Binding<Double>, yValue: Binding<Double>, horizontal: Parameter, vertical: Parameter, constants: values, horizontalSwatches: Int, verticalSwatches: Int) {
    self._xValue = xValue
    self._yValue = yValue
    self.horizontal = horizontal
    self.vertical = vertical
    self.constants = constants
    self.horizontalSwatches = horizontalSwatches
    self.verticalSwatches = verticalSwatches
    var swatches = [[values]]()
    let getValueFor: ((Parameter, Int,  Int) -> Double) = {
      parameter, xIndex, yIndex in
      if horizontal == parameter {
        return Double(xIndex) / Double(horizontalSwatches - 1)
      }
      else if vertical == parameter {
        return Double(yIndex) / Double(verticalSwatches - 1)
      }
      else {
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
    for yIndex in 0..<verticalSwatches {
      var row = [values]()
      for xIndex in 0..<horizontalSwatches {
        let swatch = (cyan: getValueFor(.cyan, xIndex, yIndex), magenta: getValueFor(.magenta, xIndex, yIndex), yellow: getValueFor(.yellow, xIndex, yIndex), black: getValueFor(.black, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex))
        row.append(swatch)
      }
      swatches.append(row)
    }
    self.swatches = swatches
  }
  
  }
struct PreviewThis: View {
  @ObservedObject var data = ColourModel(colourSpace: .CMYKA)
  var body: some View {
    VStack {
      PreviewColourView(colour: data.colour, square: true)
    CMYKAPaletteView(xValue: $data.valuesInCMYKA.cyan, yValue: $data.valuesInCMYKA.magenta, horizontal: .cyan, vertical: .magenta, constants: data.valuesInCMYKA, horizontalSwatches: 10, verticalSwatches: 10)
    }
  }
}
struct CMYKAPaletteView_Previews: PreviewProvider {
  
  static var previews: some View {
    TransparencyCheckerboardView()
  }
}
