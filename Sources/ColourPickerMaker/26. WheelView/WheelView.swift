//  WheelView.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

public struct RGBAWheelView: WheelPickable {
  public typealias DataType = RGBAData
  public let data: DataType
  @State public var thumbOffset = CGPoint()
  public var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
  public let angularGradient: Gradient
  public let radialGradient: Gradient
  public init(data: DataType) {
    self.data = data
    angularGradient = Gradient.fromValues(data.values, parameter: data.parameters.0)
    radialGradient = Gradient.fromValues(data.values, parameter: data.parameters.1)
  }
}

public struct HSBAWheelView: WheelPickable {
  public typealias DataType = HSBAData
  public let data: DataType
  @State public var thumbOffset = CGPoint()
  public var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
  public let angularGradient: Gradient
  public let radialGradient: Gradient
  public init(data: DataType) {
    self.data = data
    angularGradient = Gradient.fromValues(data.values, parameter: data.parameters.0)
    radialGradient = Gradient.fromValues(data.values, parameter: data.parameters.1)
  }
}

public struct CMYKAWheelView: WheelPickable {
  public typealias DataType = CMYKAData
  public let data: DataType
  @State public var thumbOffset = CGPoint()
  public var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
  public let angularGradient: Gradient
  public let radialGradient: Gradient
  public init(data: DataType) {
    self.data = data
    angularGradient = Gradient.fromValues(data.values, parameter: data.parameters.0)
    radialGradient = Gradient.fromValues(data.values, parameter: data.parameters.1)
  }
}

public struct GreyscaleWheelView: WheelPickable {
  public typealias DataType = GreyscaleData
  public let data: DataType
  @State public var thumbOffset = CGPoint()
  public var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
  public let angularGradient: Gradient
  public let radialGradient: Gradient
  public init(data: DataType) {
    self.data = data
    angularGradient = Gradient.fromValues(data.values, parameter: data.parameters.0)
    radialGradient = Gradient.fromValues(data.values, parameter: data.parameters.1)
  }
}

struct PreviewWheelView: View {
  @ObservedObject var data = ColourModel(colourSpace: .HSBA)
  
  var body: some View {
    VStack {
      PreviewColourView(colour: data.colour, square: true)
      HSBAWheelView(data: HSBAData(values: $data.valuesInHSBA, parameters: (.hue, .saturation)))
    }
  }
}

struct WheelView_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWheelView()
  }
}
