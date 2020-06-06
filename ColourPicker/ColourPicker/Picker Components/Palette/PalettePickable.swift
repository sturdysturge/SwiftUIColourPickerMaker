//
//  PalettePickable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol PalettePickable: View {
  associatedtype DataType where DataType: DataStorable
  var data: DataType { get }
  func getSwatchColour(values: DataType.ValueType) -> Color
    func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType
    var size: (rows: Int, columns: Int) { get }
    func getSwatchParameter(_ axis: Axis, swatch: DataType.ValueType) -> Double
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
                          self.data.bindingValues.x.wrappedValue = self.getSwatchParameter(.horizontal, swatch: swatch)
                          self.data.bindingValues.y.wrappedValue = self.getSwatchParameter(.vertical, swatch: swatch)
                        }
                        )
                        {
                            ZStack {
                                TransparencyCheckerboardView()
                                self.getSwatchColour(values: self.getSwatch(xIndex: xIndex, yIndex: yIndex))
                            }
                        }
                    }
                }
            }
        }
    }
  func getSwatchParameter(_ axis: Axis, swatch: DataType.ValueType) -> Double {
    let parameter = axis == .horizontal ? data.parameters.0 : data.parameters.1
    return data.getConstant(from: swatch, for: parameter)
  }
  
    func getValueFor(_ parameter: Parameter, _ xIndex: Int, _ yIndex: Int) -> Double {
      if data.parameters.0 == parameter {
            return (Double(xIndex) / Double(size.columns - 1))
                .clampFromZero(to:1)
        } else if data.parameters.1 == parameter {
            return (Double(yIndex) / Double(size.rows - 1))
                .clampFromZero(to:1)
        } else {
        return data.getConstant(from: data.values, for: parameter)
        }
    }

    func getSwatchColour(values: DataType.ValueType) -> Color {
        if let valuesInRGBA = values as? ColourModel.RGBAValues {
            return Color.fromValues(valuesInRGBA)
        } else if let valuesInHSBA = values as? ColourModel.HSBAValues {
            return Color.fromValues(valuesInHSBA)
        } else if let valuesInCMYKA = values as? ColourModel.CMYKAValues {
            return Color.fromValues(valuesInCMYKA)
        } else if let valuesInGreyscale = values as? ColourModel.GreyscaleValues {
          return Color.fromValues(valuesInGreyscale)
        }
        else {
            fatalError("Unknown data type")
        }
    }

    func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType {
        if DataType.ValueType.self == ColourModel.RGBAValues.self {
            if let returnValue = (red: getValueFor(.red, xIndex, yIndex), green: getValueFor(.green, xIndex, yIndex), blue: getValueFor(.blue, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex)) as? DataType.ValueType {
                return returnValue
            } else {
                fatalError("Could not convert to type \(DataType.ValueType.self)")
            }
        } else if DataType.ValueType.self == ColourModel.HSBAValues.self {
            if let returnValue = (hue: getValueFor(.hue, xIndex, yIndex), saturation: getValueFor(.saturation, xIndex, yIndex), brightness: getValueFor(.brightness, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex)) as? DataType.ValueType {
                return returnValue
            } else {
                fatalError("Could not convert to type \(DataType.ValueType.self)")
            }
        } else if DataType.ValueType.self == ColourModel.CMYKAValues.self {
            if let returnValue = (cyan: getValueFor(.cyan, xIndex, yIndex), magenta: getValueFor(.magenta, xIndex, yIndex), yellow: getValueFor(.yellow, xIndex, yIndex), black: getValueFor(.black, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex)) as? DataType.ValueType {
                return returnValue
            } else {
                fatalError("Could not convert to type \(DataType.ValueType.self)")
            }
        } else if DataType.ValueType.self == ColourModel.GreyscaleValues.self {
          if let returnValue = (white: getValueFor(.white, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex)) as? DataType.ValueType {
            return returnValue
          } else {
              fatalError("Could not convert to type \(DataType.ValueType.self)")
          }
        }
        else {
            fatalError("Unknown type \(DataType.ValueType.self)")
        }
    }
}
