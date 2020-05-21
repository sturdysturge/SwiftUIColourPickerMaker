//
//  HSB.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 21/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

enum HSBCanvasType {
  case
  saturationBrightness,
  saturationHue,
  saturationAlpha,
  brightnessSaturation,
  brightnessHue,
  brightnessAlpha,
  hueSaturation,
  hueBrightness,
  hueAlpha,
  alphaHue,
  alphaSaturation,
  alphaBrightness
  
  
  func gradients(hue: Double, saturation: Double, brightness: Double, alpha: Double = 1) -> some View {
    return HSBDoubleGradientView(type: self, hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }
}

struct HSBGradientsGridView: View {
  @EnvironmentObject var colourModel: ColourModel
  var body: some View {
    VStack {
      Group {
        //Saturation
        HStack {
          ZStack {
            HSBCanvasType.hueSaturation.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
            Text("hue saturation")
              .background(Color.background)
          }
          .aspectRatio(1, contentMode: .fit)
          ZStack {
            HSBCanvasType.hueBrightness.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
            Text("hue brightness")
              .background(Color.background)
          }
          .aspectRatio(1, contentMode: .fit)
          ZStack {
            HSBCanvasType.hueAlpha.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
            Text("hue alpha")
              .background(Color.background)
          }
          .aspectRatio(1, contentMode: .fit)
        }
        HStack {
          ZStack {
            HSBCanvasType.saturationHue.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
            Text("saturation hue")
              .background(Color.background)
          }
          .aspectRatio(1, contentMode: .fit)
          ZStack {
            HSBCanvasType.saturationBrightness.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
            Text("saturation brightness")
              .background(Color.background)
          }
          .aspectRatio(1, contentMode: .fit)
          
          ZStack {
            HSBCanvasType.saturationAlpha.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
            Text("saturation alpha")
              .background(Color.background)
          }
          .aspectRatio(1, contentMode: .fit)
        }
        HStack {
          ZStack {
            HSBCanvasType.brightnessHue.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
            Text("brightness hue")
              .background(Color.background)
          }
          .aspectRatio(1, contentMode: .fit)
          ZStack {
            HSBCanvasType.brightnessSaturation.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
            Text("brightness saturation")
              .background(Color.background)
          }
          .aspectRatio(1, contentMode: .fit)
          
          ZStack {
            HSBCanvasType.brightnessAlpha.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
            Text("brightness alpha")
              .background(Color.background)
          }
          .aspectRatio(1, contentMode: .fit)
        }
      }
      HStack {
        ZStack {
          HSBCanvasType.alphaHue.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
          Text("alpha hue")
            .background(Color.background)
        }
        .aspectRatio(1, contentMode: .fit)
        ZStack {
          HSBCanvasType.alphaSaturation.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
          Text("alpha saturation")
            .background(Color.background)
        }
        .aspectRatio(1, contentMode: .fit)
        
        ZStack {
          HSBCanvasType.alphaBrightness.gradients(hue: self.colourModel.hue, saturation: self.colourModel.saturation, brightness: self.colourModel.brightness)
          Text("alpha brightness")
            .background(Color.background)
        }
        .aspectRatio(1, contentMode: .fit)
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
