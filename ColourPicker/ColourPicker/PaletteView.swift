//
//  PaletteView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 30/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol PalettePickable {
  var horizontal: Parameter { get }
  var vertical: Parameter { get }
  var horizontalSwatches: Int { get }
  var verticalSwatches: Int { get }
  func getValueFor(_ parameter: Parameter, xIndex: Int, yIndex: Int) -> Double
  func getColourFromIndices(xIndex: Int, yIndex: Int) -> Color
  func getConstantForParameter(_ parameter: Parameter) -> Double
}

extension PalettePickable where Self: View {
  func getValueFor(_ parameter: Parameter, xIndex: Int, yIndex: Int) -> Double {
    if horizontal == parameter {
      return Double(xIndex) / Double(horizontalSwatches - 1)
    }
    else if vertical == parameter {
      return Double(yIndex) / Double(horizontalSwatches - 1)
    }
    else {
      return getConstantForParameter(parameter)
    }
  }
}
 

struct RGBAPaletteView: View, PalettePickable {
  @Binding var xValue: Double
  @Binding var yValue: Double
  let horizontal: Parameter
  let vertical: Parameter
  let constantRed: Double
  let constantGreen: Double
  let constantBlue: Double
  let constantAlpha: Double
  let horizontalSwatches: Int
  let verticalSwatches: Int
  
  func getConstantForParameter(_ parameter: Parameter) -> Double {
    switch parameter {
    case .red: return constantRed
    case .green: return constantGreen
    case .blue: return constantBlue
    case .alpha: return constantAlpha
    default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
  
  func getColourFromIndices(xIndex: Int, yIndex: Int) -> Color {
    return Color(red: getValueFor(.red, xIndex: xIndex, yIndex: yIndex), green: getValueFor(.green, xIndex: xIndex, yIndex: yIndex), blue: getValueFor(.blue, xIndex: xIndex, yIndex: yIndex), opacity: getValueFor(.alpha, xIndex: xIndex, yIndex: yIndex))
  }
  
  var body: some View {
    VStack {
      ForEach(0 ..< verticalSwatches, id: \.self) {
        yIndex in
        HStack {
          ForEach(0 ..< self.horizontalSwatches, id: \.self) {
            xIndex in
            Button(action: {
              self.xValue = self.getValueFor(self.horizontal, xIndex: xIndex, yIndex: yIndex)
              self.yValue = self.getValueFor(self.vertical, xIndex: xIndex, yIndex: yIndex)
            }) {
              ZStack {
                TransparencyCheckerboardView(tileSize: 5)
                self.getColourFromIndices(xIndex: xIndex, yIndex: yIndex)
              }
            }
          }
        }
      }
    }
  }
}

struct HSBAPaletteView: View, PalettePickable {
  @Binding var xValue: Double
  @Binding var yValue: Double
  let horizontal: Parameter
  let vertical: Parameter
  let constantHue: Double
  let constantSaturation: Double
  let constantBrightness: Double
  let constantAlpha: Double
  let horizontalSwatches: Int
  let verticalSwatches: Int
  
  func getConstantForParameter(_ parameter: Parameter) -> Double {
      switch parameter {
      case .hue: return constantHue
      case .saturation: return constantSaturation
      case .brightness: return constantBrightness
      case .alpha: return constantAlpha
      default: fatalError("Parameter \(parameter) not in colour space")
    }
  }
  
  func getColourFromIndices(xIndex: Int, yIndex: Int) -> Color {
    return Color(hue: getValueFor(.hue, xIndex: xIndex, yIndex: yIndex), saturation: getValueFor(.saturation, xIndex: xIndex, yIndex: yIndex), brightness: getValueFor(.brightness, xIndex: xIndex, yIndex: yIndex), opacity: getValueFor(.alpha, xIndex: xIndex, yIndex: yIndex))
  }
  
  var body: some View {
    VStack {
      ForEach(0 ..< verticalSwatches, id: \.self) {
        yIndex in
        HStack {
          ForEach(0 ..< self.horizontalSwatches, id: \.self) {
            xIndex in
            Button(action: {
              self.xValue = self.getValueFor(self.horizontal, xIndex: xIndex, yIndex: yIndex)
              self.yValue = self.getValueFor(self.vertical, xIndex: xIndex, yIndex: yIndex)
            }) {
              ZStack {
                TransparencyCheckerboardView(tileSize: 5)
                self.getColourFromIndices(xIndex: xIndex, yIndex: yIndex)
              }
            }
          }
        }
      }
    }
  }
}

struct CMYKAPaletteView: View, PalettePickable {
  @Binding var xValue: Double
  @Binding var yValue: Double
  let horizontal: Parameter
  let vertical: Parameter
  let constants: ColourModel.CMYKAValues
  let horizontalSwatches: Int
  let verticalSwatches: Int
  
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
  
  func getColourFromIndices(xIndex: Int, yIndex: Int) -> Color {
    let cyan = getValueFor(.cyan, xIndex: xIndex, yIndex: yIndex)
    let magenta = getValueFor(.magenta, xIndex: xIndex, yIndex: yIndex)
    let yellow = getValueFor(.yellow, xIndex: xIndex, yIndex: yIndex)
    let black = getValueFor(.black, xIndex: xIndex, yIndex: yIndex)
    let alpha = getValueFor(.alpha, xIndex: xIndex, yIndex: yIndex)
    return Color.fromValues((cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: alpha))
  }
  
  var body: some View {
    VStack {
      ForEach(0 ..< verticalSwatches, id: \.self) {
        yIndex in
        HStack {
          ForEach(0 ..< self.horizontalSwatches, id: \.self) {
            xIndex in
            Button(action: {
              self.xValue = self.getValueFor(self.horizontal, xIndex: xIndex, yIndex: yIndex)
              self.yValue = self.getValueFor(self.vertical, xIndex: xIndex, yIndex: yIndex)
            }) {
              ZStack {
                TransparencyCheckerboardView(tileSize: 5)
                self.getColourFromIndices(xIndex: xIndex, yIndex: yIndex)
              }
            }
          }
        }
      }
    }
  }
}
