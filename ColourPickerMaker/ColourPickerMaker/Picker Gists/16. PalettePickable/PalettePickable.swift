//  PalettePickable.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

protocol PalettePickable: View {
  /// The generic object that stores the colour values
  associatedtype DataType where DataType: ColourDataBindable
  /// The generic colour values
  var data: DataType { get }
  /// How many swatches there are horizontally and vertically
  var size: (rows: Int, columns: Int) { get }
  /// Get a colour
  /// - Parameter values: The colour values as a tuple
  func getSwatchColour(values: DataType.ValueType) -> Color
  /// Get the colour values at a specific position
  /// - Parameters:
  //   - xIndex: How far along it is horizontally
  //   - yIndex: How far along it is vertically
  func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType
  /// Get the value to pass to the binding when a swatch is tapped
  /// - Parameters:
  //   - axis: The horizontal or vertical direction
  //   - swatch: The colour values of the tapped swatch
  func getSwatchParameter(_ axis: Axis, swatch: DataType.ValueType) -> Double
  /// Get a specific parameter from a generic values tuple
  /// - Parameters:
  //   - parameter: The parameter in the same colour space
  /// - Returns: A constant Double value for that parameter
  func getConstant(from values: DataType.ValueType, for parameter: Parameter) -> Double
  
  /// How much a parameter should have changed between zero and 1 at a given point
  /// - Parameters:
  //   - parameter: The parameter that is changing
  //   - xIndex: How far along it is horizontally
  //   - yIndex: How far along it is vertically
  func getValueFor(_ parameter: Parameter, _ xIndex: Int, _ yIndex: Int) -> Double
}

extension PalettePickable {
  var body: some View {
    VStack {
      ForEach(0 ..< self.size.rows, id: \.self) {
        yIndex in
        HStack {
          ForEach(0 ..< self.size.columns, id: \.self) {
            xIndex in
            Button(action: {
              let swatch = self.getSwatch(xIndex: xIndex, yIndex: yIndex)
              self.data.bindingValues().x.wrappedValue = self.getSwatchParameter(.horizontal, swatch: swatch)
              self.data.bindingValues().y.wrappedValue = self.getSwatchParameter(.vertical, swatch: swatch)
            }
              )
            {
              ZStack {
                TransparencyCheckerboardView(tileSize: 10)
                self.getSwatchColour(values: self.getSwatch(xIndex: xIndex, yIndex: yIndex))
              }
            }
          }
        }
      }
    }
  }
  
  func getSwatchParameter(_ axis: Axis, swatch: DataType.ValueType) -> Double {
    let parameter = axis == .horizontal ? data.parameters.x : data.parameters.y
  return getConstant(from: swatch, for: parameter)
  }
  
  func getValueFor(_ parameter: Parameter, _ xIndex: Int, _ yIndex: Int) -> Double {
    if data.parameters.x == parameter {
      return (Double(xIndex) / Double(size.columns - 1))
        .clampFromZero(to: 1)
    } else if data.parameters.y == parameter {
      return (Double(yIndex) / Double(size.rows - 1))
        .clampFromZero(to: 1)
    } else {
      return getConstant(from: data.values, for: parameter)
    }
  }
}


extension PalettePickable where DataType == RGBAData {
  func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType {
    return (red: getValueFor(.red, xIndex, yIndex), green: getValueFor(.green, xIndex, yIndex), blue: getValueFor(.blue, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex))
  }
  
  func getSwatchColour(values: DataType.ValueType) -> Color {
    return Color.fromValues(values)
  }
  
  func getConstant(from values: DataType.ValueType, for parameter: Parameter) -> Double {
    switch parameter {
    case .red:
      return values.red
    case .green:
      return values.green
    case .blue:
      return values.blue
    case .alpha:
      return values.alpha
    default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
}

extension PalettePickable where DataType == HSBAData {
  func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType {
    return (hue: getValueFor(.hue, xIndex, yIndex), saturation: getValueFor(.saturation, xIndex, yIndex), brightness: getValueFor(.brightness, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex))
  }
  
  func getSwatchColour(values: DataType.ValueType) -> Color {
    return Color.fromValues(values)
  }
  
  func getConstant(from values: DataType.ValueType, for parameter: Parameter) -> Double {
    switch parameter {
    case .hue:
      return values.hue
    case .saturation:
      return values.saturation
    case .brightness:
      return values.brightness
    case .alpha:
      return values.alpha
    default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
}

extension PalettePickable where DataType == CMYKAData {
  func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType {
    (cyan: getValueFor(.cyan, xIndex, yIndex), magenta: getValueFor(.magenta, xIndex, yIndex), yellow: getValueFor(.yellow, xIndex, yIndex), black: getValueFor(.black, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex))
  }
  
  func getSwatchColour(values: DataType.ValueType) -> Color {
    return Color.fromValues(values)
  }
  
  func getConstant(from values: DataType.ValueType, for parameter: Parameter) -> Double {
    switch parameter {
    case .cyan:
      return values.cyan
    case .magenta:
      return values.magenta
    case .yellow:
      return values.yellow
    case .black:
      return values.black
    case .alpha:
      return values.alpha
    default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
}

extension PalettePickable where DataType == GreyscaleData {
  func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType {
    (white: getValueFor(.white, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex))
  }
  
  func getSwatchColour(values: DataType.ValueType) -> Color {
    return Color.fromValues(values)
  }
  
  func getConstant(from values: DataType.ValueType, for parameter: Parameter) -> Double {
    switch parameter {
    case .white: return values.white
    case .alpha: return values.alpha
    default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
}

