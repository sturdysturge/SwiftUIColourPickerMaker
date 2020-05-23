//
//  HSB.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 21/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI
@available(iOS 13.0, *)
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

@available(iOS 13.0, *)
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
                  .background(Color(UIColor.systemBackground))
              }
              .aspectRatio(1, contentMode: .fit)
            }
        }
      }
    }
  }
}

@available(iOS 13.0, *)
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
      GridBackgroundView(squareSize: 20)
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

@available(iOS 13.0, *)
public struct HSBPickerView: View {
  public init() {}
  @EnvironmentObject var colourModel: ColourModel
  public var body: some View {
    VStack(spacing: 5) {
      ColourCanvasView(hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha, canvasType: .saturationBrightness)
      ColourSlider(sliderType: .saturation, hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha)
    }
  }
}


@available(iOS 13.0, *)
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
@available(iOS 13.0, *)
struct HSB_Previews: PreviewProvider {
  public static var previews: some View {
    PreviewView()
  }
}
