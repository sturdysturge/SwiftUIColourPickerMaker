////
////  Extensions.swift
////  ColourPicker
////
////  Created by Rob Sturgeon on 30/05/2020.
////  Copyright © 2020 Rob Sturgeon. All rights reserved.
////
//
//import SwiftUI
//
//extension Color {
//  
//  /// The colour indigo is needed for the hue gradient
//  static let indigo = Color(red: 0.29, green: 0, blue: 0.5)
//  /// The colour violet is needed for the hue gradient
//  static let violet = Color(red: 0.93, green: 0.5, blue: 0.93)
//  #if canImport(UIKit)
//  /// A colour scheme independent background colour (Light or Dark mode)
//  static let background = Color(UIColor.systemBackground)
//  #else
//  /// A colour scheme independent background colour (Light or Dark mode)
//  static let background = Color(NSColor.windowBackgroundColor)
//  #endif
//  
//  
//  /// A way to create Color instances from HSB tuples
//  /// - Parameters:
//  ///   - valuesInHSB: A tuple containing hue, saturation and brightness as Doubles
//  ///   - alpha: The optional alpha component (set to 1 if not passed)
//  /// - Returns: A colour made from the tuple's parameters
//  static func fromValues(_ valuesInHSB: ColourModel.HSBValues, alpha: Double = 1) -> Color {
//    return Color(hue: valuesInHSB.hue, saturation: valuesInHSB.saturation, brightness: valuesInHSB.brightness, opacity: alpha)
//  }
//  
//  
//  /// A way to create Color instances from RGB tuples
//  /// - Parameters:
//  ///   - valuesInRGB: A tuple containing red, green and blue as Doubles
//  ///   - alpha: The optional alpha component (set to 1 if not passed)
//  /// - Returns: A colour made from the tuple's parameters
//  static func fromValues(_ valuesInRGB: ColourModel.RGBValues, alpha: Double = 1) -> Color {
//    return Color(red: valuesInRGB.red, green: valuesInRGB.green, blue: valuesInRGB.blue, opacity: alpha)
//  }
//  
//  /// Calculate the hue based on RGB values
//  /// - Parameters:
//  ///   - max: The highest value of R, G or B
//  ///   - delta: The difference between the minimum and maximum values of RGB
//  ///   - red: The amount of red between 0 and 1
//  ///   - green: The amount of green between 0 and 1
//  ///   - blue: The amount of blue between 0 and 1
//  /// - Returns: The value of hue between 0 and 1
//  static func calculateHue(max: Double, delta: Double, red: Double, green: Double, blue: Double) -> Double  {
//    if red == max { return (green - blue) / delta }
//    else if green == max { return 2 + (blue - red) / delta }
//    else { return 4 + (red - green) / delta }
//  }
//  
//  //=================
//  //MARK:- RGB to HSB
//  //=================
//  
//  /// Convert RGB values to HSB values
//  /// - Parameters:
//  ///   - valuesInRGB: A tuple containing red, green and blue as Doubles
//  /// - Returns: A tuple containing hue, saturation and brightness as Doubles
//  static func convertToHSB(_ valuesInRGB: ColourModel.RGBValues) -> ColourModel.HSBValues {
//    let rgbArray = [valuesInRGB.red, valuesInRGB.green, valuesInRGB.blue]
//    guard let min = rgbArray.min() else {
//      fatalError("No minimum was found")
//    }
//    guard let max = rgbArray.max() else {
//      fatalError("No maximum was found")
//    }
//    
//    let brightness = max
//    let delta = max - min
//    let saturation = delta / max
//    
//    guard delta > 0.00001 else {
//      //Colour is white
//      return (hue: 0, saturation: 0, brightness: max) }
//    guard max > 0 else {
//      //Colour is grey
//      return (hue: 1.0, saturation: 1.0, brightness: 1.0)
//    }
//    
//    //Finds the angle of the hue on the colour wheel
//    let hue = calculateHue(max: max, delta: delta, red: valuesInRGB.red, green: valuesInRGB.green, blue: valuesInRGB.blue) * 60
//    
//    return (hue: hue < 0 ? hue + 360 : hue, saturation: saturation, brightness: brightness)
//  }
//  
//  //=================
//  //MARK:- CMYK to HSB
//  //=================
//  
//  /// Convert CMYK values to HSB values
//  /// - Parameters:
//  ///   - valuesInCMYK: A tuple containing cyan, magenta, yellow and black as Doubles
//  /// - Returns: A tuple containing hue, saturation and brightness as Doubles
//  static func convertToHSB(_ valuesInCMYK: ColourModel.CMYKValues) -> ColourModel.HSBValues {
//    //No direct conversion but can convert from RGB
//    let valuesInRGB = convertToRGB(valuesInCMYK)
//    return convertToHSB(valuesInRGB)
//  }
//  
//  //=================
//  //MARK:- HSB to RGB
//  //=================
//  
//  /// Convert HSB values to RGB values
//  /// - Parameters:
//  ///   - valuesInHSB: A tuple containing hue, saturation and brightness as Doubles
//  /// - Returns: A tuple containing red, green and blue as Doubles
//  static func convertToRGB(_ valuesInHSB: ColourModel.HSBValues) -> ColourModel.RGBValues {
//    // Colour is grey
//    if valuesInHSB.saturation == 0 { return (red: 1.0, green: 1.0, blue: 1.0)
//    }
//    
//    let angle = (valuesInHSB.hue >= 360 ? 0 : valuesInHSB.hue)
//    //Portion of the colour wheel
//    let sector = angle / 60
//    //Round down to the nearest integer
//    let i = floor(sector)
//    //Get the decimal part of the sector
//    let f = sector - i
//    
//    let p = valuesInHSB.brightness * (1 - valuesInHSB.saturation)
//    let q = valuesInHSB.brightness * (1 - (valuesInHSB.saturation * f))
//    let t = valuesInHSB.brightness * (1 - (valuesInHSB.saturation * (1 - f)))
//    
//    switch(i) {
//    case 0:
//      return (red: valuesInHSB.brightness, green: t, blue: p)
//    case 1:
//      return (red: q, green: valuesInHSB.brightness, blue: p)
//    case 2:
//      return (red: p, green: valuesInHSB.brightness, blue: t)
//    case 3:
//      return (red: p, green: q, blue: valuesInHSB.brightness)
//    case 4:
//      return (red: t, green: p, blue: valuesInHSB.brightness)
//    default:
//      return (red: valuesInHSB.brightness, green: p, blue: q)
//    }
//  }
//  
//  //==================
//  //MARK:- CMYK to RGB
//  //==================
//  
//  /// Convert CMYK values to RGB values
//  /// - Parameters:
//  ///   - valuesInCMYK: A tuple containing cyan, magenta, yellow and black as Doubles
//  /// - Returns: A tuple containing red, green and blue as Doubles
//  static func convertToRGB(_ valuesInCMYK: ColourModel.CMYKValues) -> ColourModel.RGBValues {
//    let red = (1 - valuesInCMYK.cyan) * (1 - valuesInCMYK.black)
//    let green = (1 - valuesInCMYK.magenta) * (1 - valuesInCMYK.black)
//    let blue =  (1 - valuesInCMYK.yellow) * (1 - valuesInCMYK.black)
//    return (red: red, green: green, blue: blue)
//  }
//  
//  //==================
//  //MARK:- HSB to CMYK
//  //==================
//  
//  /// Convert HSB values to CMYK values
//  /// - Parameters:
//  ///   - valuesInHSB: A tuple containing hue, saturation and brightness as Doubles
//  /// - Returns: A tuple containing cyan, magenta, yellow and black as Doubles
//  
//  static func convertToCMYK(_ valuesInHSB: ColourModel.HSBValues) -> ColourModel.CMYKValues {
//    //No direct conversion but can convert from RGB
//    let valuesInRGB = convertToRGB(valuesInHSB)
//    return convertToCMYK(valuesInRGB)
//  }
//  
//  //==================
//  //MARK:- RGB to CMYK
//  //==================
//  
//  /// Convert RGB values to CMYK values
//  /// - Parameters:
//  ///   - valuesInRGB: A tuple containing red, green and blue as Doubles
//  /// - Returns: A tuple containing cyan, magenta, yellow and black as Doubles
//  
//  static func convertToCMYK(_ valuesInRGB: ColourModel.RGBValues) -> ColourModel.CMYKValues {
//    guard let max = [valuesInRGB.red, valuesInRGB.green, valuesInRGB.blue].max() else {
//      fatalError("Could not find maximum value")
//    }
//    let black = 1 - max
//    let cyan = (1 - valuesInRGB.red - black) / (1 - black)
//    let magenta = (1 - valuesInRGB.green - black) / (1 - black)
//    let yellow = (1 - valuesInRGB.blue - black) / ( 1 - black)
//    
//    return (cyan: cyan, magenta: magenta, yellow: yellow, black: black)
//  }
//}
//
