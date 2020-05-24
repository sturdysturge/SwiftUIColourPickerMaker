//
//  File.swift
//  
//
//  Created by Rob Sturgeon on 23/05/2020.
//

import SwiftUI

public struct ColourWheelView: View {
  public init(rotation: Binding<Double>, distanceFromCentre: Binding<Double>, angularGradient: Gradient = Gradient(colors: []), radialGradient: Gradient = Gradient(colors: [])) {
    self._rotation = rotation
    self._distanceFromCentre = distanceFromCentre
    self.angularGradient = angularGradient
    self.radialGradient = radialGradient
  }
  let angularGradient: Gradient
  let radialGradient: Gradient
  @Binding var rotation: Double
  @Binding var distanceFromCentre: Double
  public var body: some View {
    GeometryReader { geometry in
    ZStack {
      AngularGradient(gradient: self.angularGradient, center: .center)
      RadialGradient(gradient: self.radialGradient, center: .center, startRadius: 0, endRadius: geometry.size.width / 2)
      Group {
      Circle()
      .stroke(lineWidth: 5)
      .frame(width: 25, height: 25)
        .radialDrag(rotation: self.$rotation, distanceFromCentre: self.$distanceFromCentre, size: geometry.size)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      }
    }
  }
}

public struct GridBackgroundView: View {
  public init(squareSize: CGFloat) {
    self.squareSize = squareSize
  }
  
  
  let squareSize: CGFloat
  
  func squareColour(horizontalIndex: Int, verticalIndex: Int) -> Color {
    if verticalIndex % 2 == 0 {
      return horizontalIndex % 2 == 0 ? .gray : .white
    }
    else {
      return horizontalIndex % 2 != 0 ? .gray : .white
    }
    
  }
  
  public var body: some View {
    GeometryReader { geometry in
    VStack(spacing: 0) {
      ForEach(0...Int(geometry.size.height / self.squareSize), id: \.self) { verticalIndex in
        HStack(spacing: 0) {
          ForEach(0...Int(geometry.size.width / self.squareSize), id: \.self) { horizontalIndex in
            Rectangle()
              .aspectRatio(1, contentMode: .fit)
              .foregroundColor(self.squareColour(horizontalIndex: horizontalIndex, verticalIndex: verticalIndex))
          }
          }
        }
      }
    }
  }
}

public struct GridPaletteView: View {
  public init(canvasType: HSBCanvasType, verticalSwatches: Int, horizontalSwatches: Int, hue: Binding<Double>, saturation: Binding<Double>, brightness: Binding<Double>, alpha: Binding<Double>) {
    self.canvasType = canvasType
    self.verticalSwatches = verticalSwatches
    self.horizontalSwatches = horizontalSwatches
    self._hue = hue
    self._saturation = saturation
    self._brightness = brightness
    self._alpha = alpha
  }
  
  
  let canvasType: HSBCanvasType
  let verticalSwatches: Int
  let horizontalSwatches: Int
  @Binding var hue: Double
  @Binding var saturation: Double
  @Binding var brightness: Double
  @Binding var alpha: Double
  
  func getColourParameters(yIndex: Int, xIndex: Int) -> (Double, Double, Double, Double) {
    let horizontalParameter = canvasType.firstSliderType
    let verticalParameter = canvasType.secondSliderType
    
    var hue = Double(1)
    var saturation = Double(1)
    var brightness = Double(1)
    var opacity = Double(1)
    
    let xDecimal = Double(xIndex) / Double(horizontalSwatches - 1)
    let yDecimal = Double(yIndex) / Double(verticalSwatches - 1)
    
    switch horizontalParameter {
      
    case .hue:
      hue = xDecimal
    case .saturation:
      saturation = xDecimal
    case .brightness:
      brightness = xDecimal
    case .alpha:
      opacity = xDecimal
    }
    
    switch verticalParameter {
      
    case .hue:
      hue = yDecimal
    case .saturation:
      saturation = yDecimal
    case .brightness:
      brightness = yDecimal
    case .alpha:
      opacity = yDecimal
    }
    
    return (hue, saturation, brightness, opacity)
  }
  
  func getColourFromIndices(yIndex: Int, xIndex: Int) -> Color {
    let colourParameters = self.getColourParameters(yIndex: yIndex, xIndex: xIndex)
    let hue = colourParameters.0
    let saturation = colourParameters.1
    let brightness = colourParameters.2
    let alpha = colourParameters.3
    
    return Color(hue: hue, saturation: saturation, brightness: brightness, opacity: alpha)
  }
  
  public var body: some View {
    VStack {
      ForEach(0..<verticalSwatches, id: \.self) {
        yIndex in
        HStack {
          ForEach(0..<self.horizontalSwatches, id: \.self) {
            xIndex in
            Button(action: {
              let colourParameters = self.getColourParameters(yIndex: yIndex, xIndex: xIndex)
              
              self.hue = colourParameters.0
              self.saturation = colourParameters.1
              self.brightness = colourParameters.2
              self.alpha = colourParameters.3
            }) {
              ZStack {
                GridBackgroundView(squareSize: 5)
              self.getColourFromIndices(yIndex: yIndex, xIndex: xIndex)
              }
            }
          }
        }
      }
    }
  }
}

public struct PreviewColorView: View {
  public init(colour: Color, square: Bool) {
    self.colour = colour
    self.square = square
  }
  
  
  let colour: Color
  let square: Bool
  public var body: some View {
    ZStack {
      
      if square {
        Group {
        GridBackgroundView(squareSize: 20)
      Rectangle()
        .foregroundColor(colour)
        }
        .aspectRatio(1, contentMode: .fit)
      }
      else {
        Group {
          GridBackgroundView(squareSize: 20)
        Rectangle()
          .foregroundColor(colour)
          }
      }
    }
  }
}

public struct ColourSlider: View {
  public init(sliderType: HSBSliderType, hue: Binding<Double>, saturation: Binding<Double>, brightness: Binding<Double>, alpha: Binding<Double>) {
    self.sliderType = sliderType
    self._hue = hue
    self._saturation = saturation
    self._brightness = brightness
    self._alpha = alpha
  }
  
  @Binding var hue: Double
  @Binding var saturation: Double
  @Binding var brightness: Double
  @Binding var alpha: Double
  let sliderType: HSBSliderType
  var bindingValue: Binding<Double> {
    switch sliderType {
      
    case .hue:
      return $hue
    case .saturation:
      return $saturation
    case .brightness:
      return $brightness
    case .alpha:
      return $alpha
    }
  }
  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        GridBackgroundView(squareSize: 20)
        .frame(height: 50, alignment: .center)
        .cornerRadius(geometry.size.height / 4)
        self.sliderType.gradient(hue: self.hue, saturation: self.saturation, brightness: self.brightness)
          .frame(height: 50, alignment: .center)
          .cornerRadius(geometry.size.height / 4)
        Group {
          Capsule()
            .stroke(lineWidth: 5)
            .frame(width: 10, height: 70)
            .horizontalDrag(value: self.bindingValue, width: geometry.size.width)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .frame(height: 70)
    .padding()
  }
}

struct SharedComponents_Previews: PreviewProvider {
  static var previews: some View {
    PreviewView()
  }
}
