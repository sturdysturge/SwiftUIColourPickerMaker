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
    var size: (rows: Int, columns: Int) { get }
    func getSwatchColour(values: DataType.ValueType) -> Color
    func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType
    func getSwatchParameter(_ axis: Axis, swatch: DataType.ValueType) -> Double
}

extension PalettePickable where DataType == RGBAData {
    func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType {
        return (red: getValueFor(.red, xIndex, yIndex), green: getValueFor(.green, xIndex, yIndex), blue: getValueFor(.blue, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex))
    }

    func getSwatchColour(values: DataType.ValueType) -> Color {
        return Color.fromValues(values)
    }
}

extension PalettePickable where DataType == HSBAData {
    func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType {
        return (hue: getValueFor(.hue, xIndex, yIndex), saturation: getValueFor(.saturation, xIndex, yIndex), brightness: getValueFor(.brightness, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex))
    }

    func getSwatchColour(values: DataType.ValueType) -> Color {
        return Color.fromValues(values)
    }
}

extension PalettePickable where DataType == CMYKAData {
    func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType {
        (cyan: getValueFor(.cyan, xIndex, yIndex), magenta: getValueFor(.magenta, xIndex, yIndex), yellow: getValueFor(.yellow, xIndex, yIndex), black: getValueFor(.black, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex))
    }

    func getSwatchColour(values: DataType.ValueType) -> Color {
        return Color.fromValues(values)
    }
}

extension PalettePickable where DataType == GreyscaleData {
    func getSwatch(xIndex: Int, yIndex: Int) -> DataType.ValueType {
        (white: getValueFor(.white, xIndex, yIndex), alpha: getValueFor(.alpha, xIndex, yIndex))
    }

    func getSwatchColour(values: DataType.ValueType) -> Color {
        return Color.fromValues(values)
    }
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
                .clampFromZero(to: 1)
        } else if data.parameters.1 == parameter {
            return (Double(yIndex) / Double(size.rows - 1))
                .clampFromZero(to: 1)
        } else {
            return data.getConstant(from: data.values, for: parameter)
        }
    }
}
