//
//  GradientType.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 22/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

enum GradientType {
  case red, green, blue, brightnessOverlay, saturationOverlay, hue, alpha, cyan, yellow, purple
  
  var colours: [Color] {
    switch self {
    case .red:
        return [.clear, .red]
    case .green:
        return [.clear, .green]
    case .blue:
        return [.clear, .blue]
    case .cyan:
      return [.clear, Color(red: 0, green: 1, blue: 1, opacity: 0.7)]
    case .yellow:
      return [.clear, Color(red: 1, green: 1, blue: 0, opacity: 0.7)]
    case .purple:
      return [.clear, Color(red: 1, green: 0, blue: 1, opacity: 0.5)]
    case .brightnessOverlay:
      return [.black, Color(.sRGBLinear, white: 0, opacity: 0.7), Color(.sRGBLinear, white: 0, opacity: 0.5), Color(.sRGBLinear, white: 0, opacity: 0.3)]
    case .saturationOverlay:
      return [.white, Color(.sRGBLinear, white: 1, opacity: 0.9), Color(.sRGBLinear, white: 1, opacity: 0.5), Color(.sRGBLinear, white: 1, opacity: 0.3)]
    case .hue:
        return [.red, .yellow, .green, .blue, .indigo, .violet, .red]
    case .alpha:
        return [Color(.sRGBLinear, white: 1, opacity: 0.5), Color(.sRGBLinear, white: 1, opacity: 0.9), .white]
    }
  }
  
  static func brightness(hue: Double, saturation: Double, startPoint: UnitPoint) -> LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color(hue: hue, saturation: 1, brightness: 0), Color(hue: hue, saturation: 1, brightness: 1)]), startPoint: startPoint, endPoint: startPoint.opposite)
  }
  
  static func saturation(hue: Double, brightness: Double, startPoint: UnitPoint) -> LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [.white, Color(hue: hue, saturation: 1, brightness: 1)]), startPoint: startPoint, endPoint: startPoint.opposite)
  }
  var gradient: Gradient { Gradient(colors: colours) }
    
  var horizontal: LinearGradient { LinearGradient(gradient: self.gradient, startPoint: .leading, endPoint: .trailing) }
  
  var vertical: LinearGradient { LinearGradient(gradient: self.gradient, startPoint: .top, endPoint: .bottom) }
  
  var diagonal: LinearGradient { LinearGradient(gradient: self.gradient, startPoint: .topLeading, endPoint: .bottomTrailing) }
}
