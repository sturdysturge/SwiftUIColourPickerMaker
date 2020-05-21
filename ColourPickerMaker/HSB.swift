//
//  HSB.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 21/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

enum HSBCanvasType: String, CaseIterable {
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
  
  
  func gradients(hue: Double, saturation: Double, brightness: Double, alpha: Double = 1) -> some View {
    return HSBDoubleGradientView(type: self, hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }
}

struct HSBGradientsGridView: View {
  @EnvironmentObject var colourModel: ColourModel
  let rowSize = 4
  
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
  var body: some View {
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

struct HSBDoubleGradientView: View {
  let type: HSBCanvasType
  let hue: Double
  let saturation: Double
  let brightness: Double
  let alpha: Double
  var body: some View {
    ZStack {
      GridBackgroundView()
      if type == .saturationBrightness {
        GradientType.saturation(hue: hue, axis: .horizontal)
        GradientType.brightnessOverlay.vertical
      }
      else if type == .saturationHue {
        GradientType.hue.vertical
        GradientType.saturationOverlay.horizontal
      }
      else if type == .saturationAlpha {
        GradientType.saturation(hue: hue, axis: .horizontal)
          .mask (
          GradientType.alpha.vertical
        )
      }
      else if type == .brightnessSaturation {
        GradientType.brightness(hue: hue, axis: .horizontal)
        GradientType.saturationOverlay.vertical
      }
        
      else if type == .brightnessHue {
        GradientType.hue.vertical
        GradientType.brightnessOverlay.horizontal
      }
      else if type == .brightnessAlpha {
        GradientType.brightness(hue: hue, axis: .horizontal).mask (
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
        GradientType.hue.vertical
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
        GradientType.saturation(hue: hue, axis: .vertical).mask (
          GradientType.alpha.horizontal
        )
      }
      else if type == .alphaBrightness {
        GradientType.brightness(hue: hue, axis: .vertical)
          .mask (
          GradientType.alpha.horizontal
        )
      }
    }
  }
}

struct HSBPickerView: View {
  @EnvironmentObject var colourModel: ColourModel
  var body: some View {
    VStack(spacing: 5) {
      ColourCanvas(hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha, canvasType: .saturationBrightness)
      ColourSlider(hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha, sliderType: .saturation)
      PreviewColorView(colour: colourModel.colour)
    }
  }
}



enum HSBSliderType {
  case hue, saturation, brightness, alpha
  
  func gradient(hue: Double) -> LinearGradient {
    switch self {
      
    case .hue:
      return GradientType.hue.horizontal
    case .saturation:
      return GradientType.saturation(hue: hue, axis: .horizontal)
    case .brightness:
      return GradientType.brightness(hue: hue, axis: .horizontal)
    case .alpha:
      return GradientType.alpha.horizontal
    }
  }
}

struct HSB_Previews: PreviewProvider {
  static var previews: some View {
    /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
  }
}