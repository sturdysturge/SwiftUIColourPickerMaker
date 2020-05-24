//
//  HSB.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 21/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

public enum HSBCanvasType: String, CaseIterable {
  case
  saturationBrightness = "saturation brightness",
  saturationHue = "saturation hue",
  saturationAlpha = "saturation alpha",
  brightnessSaturation = "brightness saturation",
  brightnessHue = "brightness hue",
  brightnessAlpha = "brightness alpha",
  hueSaturation = "hue saturation",
  hueBrightness = "hue brightness",
  hueAlpha = "hue alpha",
  alphaHue = "alpha hue",
  alphaSaturation = "alpha saturation",
  alphaBrightness = "alpha brightness"
  
  var firstSliderType: HSBSliderType {
    switch self {
      
    case .saturationBrightness:
      return .saturation
    case .saturationHue:
      return .saturation
    case .saturationAlpha:
      return .saturation
    case .brightnessSaturation:
      return .brightness
    case .brightnessHue:
      return .brightness
    case .brightnessAlpha:
      return .brightness
    case .hueSaturation:
      return .hue
    case .hueBrightness:
      return .hue
    case .hueAlpha:
      return .hue
    case .alphaHue:
      return .alpha
    case .alphaSaturation:
      return .alpha
    case .alphaBrightness:
      return .alpha
    }
  }
  
  var secondSliderType: HSBSliderType {
    switch self {
      
    case .saturationBrightness:
      return .brightness
    case .saturationHue:
      return .hue
    case .saturationAlpha:
      return .alpha
    case .brightnessSaturation:
      return .saturation
    case .brightnessHue:
      return .hue
    case .brightnessAlpha:
      return .alpha
    case .hueSaturation:
      return .saturation
    case .hueBrightness:
      return .brightness
    case .hueAlpha:
      return .alpha
    case .alphaHue:
      return .hue
    case .alphaSaturation:
      return .saturation
    case .alphaBrightness:
      return .brightness
    }
  }
  
  
  func gradients(hue: Double, saturation: Double, brightness: Double, alpha: Double = 1) -> some View {
    return HSBDoubleGradientView(type: self, hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }
}

protocol GridPreviewable {
  var rowSize: Int { get }
  func getRow<T>(number: Int, fromArray array: [T]) -> [T]
  func numberOfRows(for arraySize: Int) -> Int
  
}

extension GridPreviewable {
  func getRow<T>(number: Int, fromArray array: [T]) -> [T] {
    var returnArray = [T]()
    let startOfRow = ((number - 1) * rowSize)
    let endOfRow = startOfRow + (rowSize - 1)
    for index in startOfRow...endOfRow {
      if array.indices.contains(index) {
        returnArray.append(array[index])
      }
      else { break }
    }
    return returnArray
  }
  
  func numberOfRows(for arraySize: Int) -> Int {
    return Int((Double(arraySize) / Double(rowSize)) + 0.5)
  }
}

public struct EveryHSBColourCanvasView: View {
  public init() {}
  @EnvironmentObject var colourModel: ColourModel
  public var body: some View {
    VStack {
      PreviewColorView(colour: colourModel.colour, square: false)
        .frame(maxWidth: .infinity, maxHeight: 100)
    ScrollView {
      VStack {
      ForEach(HSBCanvasType.allCases, id: \.self) {
        type in
        Group {
        Text(type.rawValue)
        HSBColourCanvasView(hue: self.$colourModel.hue, saturation: self.$colourModel.saturation, brightness: self.$colourModel.brightness, alpha: self.$colourModel.alpha, canvasType: type)
          .environmentObject(self.colourModel)
        }
        }
      }
      }
      
    }
  }
}

public struct HSBColourCanvasView: View {
  public init(hue: Binding<Double>, saturation: Binding<Double>, brightness: Binding<Double>, alpha: Binding<Double>, canvasType: HSBCanvasType) {
    self._hue = hue
    self._saturation = saturation
    self._brightness = brightness
    self._alpha = alpha
    self.canvasType = canvasType
  }
  
  @Binding var hue: Double
  @Binding var saturation: Double
  @Binding var brightness: Double
  @Binding var alpha: Double
  let canvasType: HSBCanvasType
  
  func bindingValues() -> (Binding<Double>, Binding<Double>) {
    switch canvasType {
      
    case .saturationBrightness:
      return ($saturation, $brightness)
    case .saturationHue:
      return ($saturation, $hue)
    case .saturationAlpha:
      return ($saturation, $alpha)
    case .brightnessSaturation:
      return ($brightness, $saturation)
    case .brightnessHue:
      return ($brightness, $hue)
    case .brightnessAlpha:
      return ($brightness, $alpha)
    case .hueSaturation:
      return ($hue, $saturation)
    case .hueBrightness:
      return ($hue, $brightness)
    case .hueAlpha:
      return ($hue, $alpha)
    case .alphaHue:
      return ($alpha, $hue)
    case .alphaSaturation:
      return ($alpha, $saturation)
    case .alphaBrightness:
      return ($alpha, $brightness)
    }
  }
  
  public var body: some View {
    ZStack {
      GeometryReader { geometry in
        self.canvasType.gradients(hue: self.hue, saturation: self.saturation, brightness: self.brightness)
        Group {
          Circle()
            .stroke(lineWidth: 5)
            .frame(width: 25, height: 25)
            .bidirectionalDrag(xValue: self.bindingValues().0, yValue: self.bindingValues().1, size: geometry.size)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      }
    }
    .background(TransparencyCheckerboardView(squareSize: 20))
    .aspectRatio(1, contentMode: .fit)
  }
}

public struct HSBGradientsGridView: View, GridPreviewable {
  public init() {}
  @EnvironmentObject var colourModel: ColourModel
  let rowSize = 4
  
  public var body: some View {
    VStack {
      ForEach(1...numberOfRows(for: HSBCanvasType.allCases.count), id: \.self) { row in
          HStack {
            ForEach(self.getRow(number: row, fromArray: HSBCanvasType.allCases), id: \.self) {
              canvasType in
              ZStack {
              canvasType.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness, alpha: self.colourModel.alpha)
                Text(canvasType.rawValue)
                  .background(Color.background)
              }
              .aspectRatio(1, contentMode: .fit)
            }
        }
      }
    }
  }
}


public struct HSBDoubleGradientView: View {
  public init(type: HSBCanvasType, hue: Double, saturation: Double, brightness: Double, alpha: Double) {
    self.type = type
    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
    self.alpha = alpha
  }
  
  
  let type: HSBCanvasType
  let hue: Double
  let saturation: Double
  let brightness: Double
  let alpha: Double
  public var body: some View {
    ZStack {
      TransparencyCheckerboardView(squareSize: 20)
      if type == .saturationBrightness {
        GradientType.saturation(hue: hue, brightness: brightness, startPoint: .leading)
        GradientType.brightnessOverlay.vertical
      }
      else if type == .saturationHue {
        GradientType.hue.vertical
        GradientType.saturationOverlay.horizontal
      }
      else if type == .saturationAlpha {
        GradientType.saturation(hue: hue, brightness: brightness, startPoint: .leading)
          .mask (
          GradientType.alpha.vertical
        )
      }
      else if type == .brightnessSaturation {
        GradientType.brightness(hue: hue, saturation: saturation, startPoint: .leading)
        GradientType.saturationOverlay.vertical
      }
        
      else if type == .brightnessHue {
        GradientType.hue.vertical
        GradientType.brightnessOverlay.horizontal
      }
      else if type == .brightnessAlpha {
        GradientType.brightness(hue: hue, saturation: saturation, startPoint: .leading).mask (
          GradientType.alpha.vertical
        )
      }
      else if type == .hueSaturation {
        GradientType.hue.horizontal
        GradientType.saturationOverlay.vertical
      }
      else if type == .hueBrightness {
        GradientType.hue.horizontal
        GradientType.brightnessOverlay.vertical
        
      }
      else if type == .hueAlpha {
        GradientType.hue.horizontal
          .mask (
            GradientType.alpha.vertical
        )
        
      }
      else if type == .alphaHue {
        GradientType.hue.vertical
        .mask (
        GradientType.alpha.horizontal
        )
      }
      else if type == .alphaSaturation {
        GradientType.saturation(hue: hue, brightness: brightness, startPoint: .top).mask (
          GradientType.alpha.horizontal
        )
      }
      else if type == .alphaBrightness {
        GradientType.brightness(hue: hue, saturation: saturation, startPoint: .top)
          .mask (
          GradientType.alpha.horizontal
        )
      }
    }
  }
}


public struct HSBPickerView: View {
  public init() {}
  @EnvironmentObject var colourModel: ColourModel
  public var body: some View {
    VStack(spacing: 5) {
      HSBColourCanvasView(hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha, canvasType: .saturationBrightness)
      ColourSlider(sliderType: .saturation, hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha)
    }
  }
}



public enum HSBSliderType {
  case hue, saturation, brightness, alpha
  
  func gradient(hue: Double, saturation: Double, brightness: Double) -> LinearGradient {
    switch self {
      
    case .hue:
      return GradientType.hue.horizontal
    case .saturation:
      return GradientType.saturation(hue: hue, brightness: brightness, startPoint: .leading)
    case .brightness:
      return GradientType.brightness(hue: hue, saturation: saturation, startPoint: .leading)
    case .alpha:
      return GradientType.alpha.horizontal
    }
  }
}

struct HSB_Previews: PreviewProvider {
  public static var previews: some View {
    PreviewView()
  }
}
