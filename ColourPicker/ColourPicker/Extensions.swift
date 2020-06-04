//
//  Extensions.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 30/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

extension Gradient {
  static let hue = Gradient(colors: [.red, .yellow, .green, .blue, .indigo, .violet, .red])
}

extension Color {
  /// The colour indigo is needed for the hue gradient
  static let indigo = Color(red: 0.29, green: 0, blue: 0.5)
  /// The colour violet is needed for the hue gradient
  static let violet = Color(red: 0.93, green: 0.5, blue: 0.93)
  /// The colour cyan needed for the CMYKA colour space
  static let cyan = Color(UIColor.cyan)
  /// The colour magenta needed for the CMYKA colour space
  static let magenta = Color(UIColor.magenta)
  #if canImport(UIKit)
  /// A colour scheme independent background colour (Light or Dark mode)
  static let background = Color(UIColor.systemBackground)
  #else
  /// A colour scheme independent background colour (Light or Dark mode)
  static let background = Color(NSColor.windowBackgroundColor)
  #endif
  
  static func blend(colour1: ColourModel.RGBAValues, colour2: ColourModel.RGBAValues, alpha: Double) -> ColourModel.RGBAValues {
    return (red: colour1.red + colour2.red, green: colour1.green + colour2.green, blue: colour1.blue + colour2.blue, alpha: alpha)
  }
  
  static func blend(colour1: ColourModel.HSBAValues, colour2: ColourModel.HSBAValues, alpha: Double) -> ColourModel.HSBAValues {
    return (hue: colour1.hue + colour2.hue, saturation: colour1.saturation + colour2.saturation, brightness: colour1.brightness + colour2.brightness, alpha: alpha)
  }
  
  static func blend(colour1: ColourModel.CMYKAValues, colour2: ColourModel.CMYKAValues, alpha: Double) -> ColourModel.CMYKAValues {
    return (cyan: colour1.cyan + colour2.cyan, magenta: colour1.magenta + colour2.magenta, yellow: colour1.yellow + colour2.yellow, black: colour1.black + colour2.black, alpha: alpha)
  }
  
  /// A way to create Color instances from HSBA tuples
  /// - Parameters:
  ///   - valuesInHSBA: A tuple containing hue, saturation and brightness as Doubles
  ///   - alpha: The optional alpha component (set to 1 if not passed)
  /// - Returns: A colour made from the tuple's parameters
  static func fromValues(_ valuesInHSBA: ColourModel.HSBAValues) -> Color {
    return Color(hue: valuesInHSBA.hue, saturation: valuesInHSBA.saturation, brightness: valuesInHSBA.brightness, opacity: valuesInHSBA.alpha)
  }
  
  /// A way to create Color instances from HSBA tuples
  /// - Parameters:
  ///   - valuesInCMYKA: A tuple containing cyan, magenta, yellow, black and alpha as Doubles
  ///   - alpha: <#alpha description#>
  /// - Returns: <#description#>
  static func fromValues(_ valuesInCMYKA: ColourModel.CMYKAValues) -> Color {
    return fromValues(convertToRGBA(valuesInCMYKA))
  }
  
  /// A way to create Color instances from RGBA tuples
  /// - Parameters:
  ///   - valuesInRGBA: A tuple containing red, green and blue as Doubles
  ///   - alpha: The optional alpha component (set to 1 if not passed)
  /// - Returns: A colour made from the tuple's parameters
  static func fromValues(_ valuesInRGBA: ColourModel.RGBAValues) -> Color {
    return Color(red: valuesInRGBA.red, green: valuesInRGBA.green, blue: valuesInRGBA.blue, opacity: valuesInRGBA.alpha)
  }
  
  /// Calculate the hue based on RGBA values
  /// - Parameters:
  ///   - max: The highest value of R, G or B
  ///   - delta: The difference between the minimum and maximum values of RGBA
  ///   - red: The amount of red between 0 and 1
  ///   - green: The amount of green between 0 and 1
  ///   - blue: The amount of blue between 0 and 1
  /// - Returns: The value of hue between 0 and 1
  static func calculateHue(max: Double, delta: Double, red: Double, green: Double, blue: Double) -> Double {
    if red == max { return (green - blue) / delta }
    else if green == max { return 2 + (blue - red) / delta }
    else { return 4 + (red - green) / delta }
  }
  
  //=================
  
  // MARK: - RGBA to HSBA
  
  //=================
  
  /// Convert RGBA values to HSBA values
  /// - Parameters:
  ///   - valuesInRGBA: A tuple containing red, green and blue as Doubles
  /// - Returns: A tuple containing hue, saturation and brightness as Doubles
  static func convertToHSBA(_ valuesInRGBA: ColourModel.RGBAValues) -> ColourModel.HSBAValues {
    let arrayOfRGBA = [valuesInRGBA.red, valuesInRGBA.green, valuesInRGBA.blue]
    guard let min = arrayOfRGBA.min() else {
      fatalError("No minimum was found")
    }
    guard let max = arrayOfRGBA.max() else {
      fatalError("No maximum was found")
    }
    
    let brightness = max
    let delta = max - min
    let saturation = delta / max
    
    guard delta > 0.00001 else {
      // Colour is white
      return (hue: 0, saturation: 0, brightness: max, alpha: valuesInRGBA.alpha)
    }
    guard max > 0 else {
      // Colour is grey
      return (hue: 1.0, saturation: 1.0, brightness: 1.0, alpha: valuesInRGBA.alpha)
    }
    
    // Finds the angle of the hue on the colour wheel
    let hue = calculateHue(max: max, delta: delta, red: valuesInRGBA.red, green: valuesInRGBA.green, blue: valuesInRGBA.blue) * 60
    
    return (hue: hue < 0 ? hue + 360 : hue, saturation: saturation, brightness: brightness, alpha: valuesInRGBA.alpha)
  }
  
  //=================
  
  // MARK: - CMYKA to HSBA
  
  //=================
  
  /// Convert CMYKA values to HSBA values
  /// - Parameters:
  ///   - valuesInCMYKA: A tuple containing cyan, magenta, yellow and black as Doubles
  /// - Returns: A tuple containing hue, saturation and brightness as Doubles
  static func convertToHSBA(_ valuesInCMYKA: ColourModel.CMYKAValues) -> ColourModel.HSBAValues {
    // No direct conversion but can convert from RGBA
    let valuesInRGBA = convertToRGBA(valuesInCMYKA)
    return convertToHSBA(valuesInRGBA)
  }
  
  //=================
  
  // MARK: - HSBA to RGBA
  
  //=================
  
  /// Convert HSBA values to RGBA values
  /// - Parameters:
  ///   - valuesInHSBA: A tuple containing hue, saturation and brightness as Doubles
  /// - Returns: A tuple containing red, green and blue as Doubles
  static func convertToRGBA(_ valuesInHSBA: ColourModel.HSBAValues) -> ColourModel.RGBAValues {
    // Colour is grey
    if valuesInHSBA.saturation == 0 { return (red: 1.0, green: 1.0, blue: 1.0, alpha: valuesInHSBA.alpha)
    }
    
    let angle = (valuesInHSBA.hue >= 360 ? 0 : valuesInHSBA.hue)
    // Portion of the colour wheel
    let sector = angle / 60
    // Round down to the nearest integer
    let i = floor(sector)
    // Get the decimal part of the sector
    let f = sector - i
    
    let p = valuesInHSBA.brightness * (1 - valuesInHSBA.saturation)
    let q = valuesInHSBA.brightness * (1 - (valuesInHSBA.saturation * f))
    let t = valuesInHSBA.brightness * (1 - (valuesInHSBA.saturation * (1 - f)))
    
    switch i {
    case 0:
      return (red: valuesInHSBA.brightness, green: t, blue: p, alpha: valuesInHSBA.alpha)
    case 1:
      return (red: q, green: valuesInHSBA.brightness, blue: p, alpha: valuesInHSBA.alpha)
    case 2:
      return (red: p, green: valuesInHSBA.brightness, blue: t, alpha: valuesInHSBA.alpha)
    case 3:
      return (red: p, green: q, blue: valuesInHSBA.brightness, alpha: valuesInHSBA.alpha)
    case 4:
      return (red: t, green: p, blue: valuesInHSBA.brightness, alpha: valuesInHSBA.alpha)
    default:
      return (red: valuesInHSBA.brightness, green: p, blue: q, alpha: valuesInHSBA.alpha)
    }
  }
  
  //==================
  
  // MARK: - CMYKA to RGBA
  
  //==================
  
  /// Convert CMYKA values to RGBA values
  /// - Parameters:
  ///   - valuesInCMYKA: A tuple containing cyan, magenta, yellow and black as Doubles
  /// - Returns: A tuple containing red, green and blue as Doubles
  static func convertToRGBA(_ valuesInCMYKA: ColourModel.CMYKAValues) -> ColourModel.RGBAValues {
    let red = (1 - valuesInCMYKA.cyan) * (1 - valuesInCMYKA.black)
    let green = (1 - valuesInCMYKA.magenta) * (1 - valuesInCMYKA.black)
    let blue = (1 - valuesInCMYKA.yellow) * (1 - valuesInCMYKA.black)
    return (red: red, green: green, blue: blue, alpha: valuesInCMYKA.alpha)
  }
  
  //==================
  
  // MARK: - HSBA to CMYKA
  
  //==================
  
  /// Convert HSBA values to CMYKA values
  /// - Parameters:
  ///   - valuesInHSBA: A tuple containing hue, saturation and brightness as Doubles
  /// - Returns: A tuple containing cyan, magenta, yellow and black as Doubles
  
  static func convertToCMYKA(_ valuesInHSBA: ColourModel.HSBAValues) -> ColourModel.CMYKAValues {
    // No direct conversion but can convert from RGBA
    let valuesInRGBA = convertToRGBA(valuesInHSBA)
    return convertToCMYKA(valuesInRGBA)
  }
  
  //==================
  
  // MARK: - RGBA to CMYKA
  
  //==================
  
  /// Convert RGBA values to CMYKA values
  /// - Parameters:
  ///   - valuesInRGBA: A tuple containing red, green and blue as Doubles
  /// - Returns: A tuple containing cyan, magenta, yellow and black as Doubles
  
  static func convertToCMYKA(_ valuesInRGBA: ColourModel.RGBAValues) -> ColourModel.CMYKAValues {
    guard let max = [valuesInRGBA.red, valuesInRGBA.green, valuesInRGBA.blue].max() else {
      fatalError("Could not find maximum value")
    }
    let black = 1 - max
    let cyan = (1 - valuesInRGBA.red - black) / (1 - black)
    let magenta = (1 - valuesInRGBA.green - black) / (1 - black)
    let yellow = (1 - valuesInRGBA.blue - black) / (1 - black)
    
    return (cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: valuesInRGBA.alpha)
  }
}

extension View {
  /**
   A way to use DirectionalDragModifier without calling it directly
   - Parameters:
   - value: A Binding so that the slider's value changes are passed back
   - length: The length of the slider (horizontally or vertically)
   - orientation: The orientation of the slider (horizontally or vertically)
   - Returns: A View that has dragging functionality
   */
  func drag(value: Binding<Double>, length: CGFloat, orientation: Axis) -> some View {
    return modifier(DirectionalDragModifier(value: value, length: length, orientation: orientation))
  }
  
  
  /** A way to use BidirectionalDragModifier without calling it directly
   - Parameters:
   - xValue: The value based on horizontal position between 0 and 1
   - yValue: The value based on vertical position between 0 and 1
   - size: The size of the canvas
   - Returns: A View that has bidirectional dragging functionality
   */
  func bidirectionalDrag(xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) -> some View {
    return modifier(BidirectionalDragModifier(xValue: xValue, yValue: yValue, size: size))
  }
}
