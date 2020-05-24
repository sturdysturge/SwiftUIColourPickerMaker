//
//  Extension.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 21/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

public extension Color {
    static func calculateHue(max: Double, delta: Double, red: Double, green: Double, blue: Double) -> Double  {
        if red == max { return (green - blue) / delta }
        else if green == max { return 2 + (blue - red) / delta }
        else { return 4 + (red - green) / delta }
    }
    static func convertToHSB(red: Double, green: Double, blue: Double) -> Color {
      let values = convertToHSBValues(red: red, green: green, blue: blue)
      return Color(hue: values.hue, saturation: values.saturation, brightness: values.brightness)
    }
    static func convertToRGB(hue: Double, saturation: Double, brightness: Double) -> Color {
      let values = convertToRGBValues(hue: hue, saturation: saturation, brightness: brightness)
      return Color(red: values.red, green: values.green, blue: values.blue)
    }
    static func convertToHSBValues(red: Double, green: Double, blue: Double) -> (hue: Double,  saturation: Double, brightness: Double) {
      let rgbArray = [red, green, blue]
      guard let min = rgbArray.min() else {
        fatalError("No minimum was found")
      }
        guard let max = rgbArray.max() else {
          fatalError("No maximum was found")
        }
        
        let brightness = max
        let delta = max - min
      let saturation = delta / max
        
        guard delta > 0.00001 else {
          //Colour is white
          return (hue: 0, saturation: 0, brightness: max) }
        guard max > 0 else {
          //Colour is grey
          return (hue: 1.0, saturation: 1.0, brightness: 1.0)
      }
      
        //Finds the angle of the hue on the colour wheel
      let hue = calculateHue(max: max, delta: delta, red: red, green: green, blue: blue) * 60
        
        return (hue: hue < 0 ? hue + 360 : hue, saturation: saturation, brightness: brightness)
    }
    
    static func convertToRGBValues(hue: Double, saturation: Double, brightness: Double) -> (red: Double, green: Double, blue: Double) {
      // Colour is grey
      if saturation == 0 { return (red: 1.0, green: 1.0, blue: 1.0)
      }
      
      let angle = (hue >= 360 ? 0 : hue)
      //Portion of the colour wheel
      let sector = angle / 60
      //Round down to the nearest integer
      let i = floor(sector)
      //Get the decimal part of the sector
      let f = sector - i
      
      let p = brightness * (1 - saturation)
      let q = brightness * (1 - (saturation * f))
      let t = brightness * (1 - (saturation * (1 - f)))
      
      switch(i) {
      case 0:
          return (red: brightness, green: t, blue: p)
      case 1:
          return (red: q, green: brightness, blue: p)
      case 2:
          return (red: p, green: brightness, blue: t)
      case 3:
        return (red: p, green: q, blue: brightness)
      case 4:
          return (red: t, green: p, blue: brightness)
      default:
          return (red: brightness, green: p, blue: q)
      }
  }
    static let indigo = Color(red: 0.29, green: 0, blue: 0.5)
    static let violet = Color(red: 0.93, green: 0.5, blue: 0.93)
    #if canImport(UIKit)
        static let background = Color(UIColor.systemBackground)
    #else
        static let background = Color(NSColor.windowBackgroundColor)
    #endif
  
  static func fromCMYK(cyan: Double, magenta: Double, yellow: Double, black: Double, alpha: Double = 1) -> Color {
    let red = (1 - cyan) * (1 - black)
    let green = (1 - magenta) * (1 - black)
    let blue =  (1 - yellow) * (1 - black)
    return Color(red: red, green: green, blue: blue, opacity: alpha)
  }
}

public extension UnitPoint {
    var opposite: UnitPoint {
        switch self {
        case .bottom: return .top
        case .bottomLeading: return .topTrailing
        case .bottomTrailing: return .topLeading
        case .leading: return .trailing
        case .top: return .bottom
        case .topLeading: return .bottomTrailing
        case .topTrailing: return .bottomLeading
        case .trailing: return .leading
        default:
            fatalError("Direction for \(self) unknown")
        }
    }
}

public extension View {
    func horizontalDrag(value: Binding<Double>, width: CGFloat) -> some View {
        return modifier(HorizontalSlider(value: value, width: width))
    }

    func bidirectionalDrag(xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) -> some View {
        return modifier(BidirectionalSlider(xValue: xValue, yValue: yValue, size: size))
    }

    func radialDrag(rotation: Binding<Double>, distanceFromCentre: Binding<Double>, size: CGSize) -> some View {
        return modifier(RadialSlider(rotation: rotation, distanceFromCentre: distanceFromCentre, size: size))
    }
}

public extension LinearGradient {
    static func fromColours(_ colours: [Color], startPoint: UnitPoint) -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: colours), startPoint: startPoint, endPoint: startPoint.opposite)
    }
}

extension CGFloat {
    static let halfPi = CGFloat.pi / 2
    static let doublePi = CGFloat.pi * 2
}

extension CGPoint {
    func angleToPoint(_ point: CGPoint) -> CGFloat {
        let xDistance = point.x - x
        let yDistance = point.y - y
        var radians = CGFloat.halfPi - atan2(xDistance, yDistance)

        while radians < 0 {
            radians += CGFloat.doublePi
        }

        return radians
    }

    func distanceToPoint(otherPoint: CGPoint) -> CGFloat {
        return sqrt(pow(otherPoint.x - x, 2) + pow(otherPoint.y - y, 2))
    }
}

struct Extension_Previews: PreviewProvider {
    public static var previews: some View {
        PreviewView()
    }
}
