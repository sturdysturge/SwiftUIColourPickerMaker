//
//  ContentView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 28/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI
enum Control {
  case canvas, wheel, palette, slider
}
struct ContentView: View {
  internal init(parameters: (Parameter, Parameter), control: Control) {
    self.parameters = parameters
    parameters.0.checkCompatibility(with: parameters.1)
    let colourSpace = parameters.0.colourSpace
    data = ColourModel(colourSpace: colourSpace)
    self.colourSpace = colourSpace
    self.control = control
  }
  static let example = ContentView(parameters: (.hue, .saturation), control: .canvas)
  @ObservedObject var data: ColourModel
  let parameters: (Parameter, Parameter)
  let control: Control
  let colourSpace: ColourSpace
  var body: some View {
    VStack {
      PreviewColourView(colour: data.colour, square: true)
      Group {
        if control == .canvas {
          if colourSpace == .RGBA {
            RGBACanvasView(data: RGBAData(values: $data.valuesInRGBA, parameters: parameters))
          } else if colourSpace == .HSBA {
            HSBACanvasView(data: HSBAData(values: $data.valuesInHSBA, parameters: parameters))
          } else if colourSpace == .CMYKA {
            CMYKACanvasView(data: CMYKAData(values: $data.valuesInCMYKA, parameters: parameters))
          } else if colourSpace == .greyscale {
            GreyscaleCanvasView(data: GreyscaleData(values: $data.valuesInGreyscale, parameters: parameters))
          }
        }
        else if control == .palette {
          if colourSpace == .RGBA {
            RGBAPaletteView(data: RGBAData(values: $data.valuesInRGBA, parameters: parameters))
          } else if colourSpace == .HSBA {
            HSBAPaletteView(data: HSBAData(values: $data.valuesInHSBA, parameters: parameters))
          } else if colourSpace == .CMYKA {
            CMYKAPaletteView(data: CMYKAData(values: $data.valuesInCMYKA, parameters: (.cyan, .magenta)))
          } else if colourSpace == .greyscale {
            GreyscalePaletteView(data: GreyscaleData(values: $data.valuesInGreyscale, parameters: (.white, .alpha)))
          }
          else if control == .wheel {
            if colourSpace == .RGBA {
              RGBAWheelView(data: RGBAData(values: $data.valuesInRGBA, parameters: parameters))
            } else if colourSpace == .HSBA {
              HSBAWheelView(data: HSBAData(values: $data.valuesInHSBA, parameters: parameters))
            } else if colourSpace == .CMYKA {
              CMYKAWheelView(data: CMYKAData(values: $data.valuesInCMYKA, parameters: parameters))
            } else if colourSpace == .greyscale {
              GreyscaleWheelView(data: GreyscaleData(values: $data.valuesInGreyscale, parameters: parameters))
            }
          }
          if control == .slider {
            SliderView(value: $data.valuesInRGBA.red, parameter: .red, orientation: .horizontal, thickness: 70, length: 300)
          }
        }
      }
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(parameters: (.hue, .saturation), control: .canvas)
  }
}
