//
//  DoubleGradientView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 02/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI


struct DoubleGradientView: View {
  let horizontal: Parameter
  let vertical: Parameter
  let horizontalColour: Color
  let verticalColour: Color
  let blendedColour: Color
  init(horizontal: Parameter, vertical: Parameter) {
    self.horizontal = horizontal
    self.vertical = vertical
    guard horizontal.colourSpace == vertical.colourSpace else {
      fatalError("Colour spaces must be the same")
    }
    let colourSpace = horizontal.colourSpace
    switch colourSpace {
    case .RGBA:
      self.horizontalColour = Color.fromValues(horizontal.valuesInRGB)
      self.verticalColour = Color.fromValues(vertical.valuesInRGB)
      self.blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInRGB, colour2: vertical.valuesInRGB, alpha: 0.5))
      case .HSBA:
      self.horizontalColour = Color.fromValues(horizontal.valuesInHSB)
      self.verticalColour = Color.fromValues(vertical.valuesInHSB)
      self.blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInHSB, colour2: vertical.valuesInHSB, alpha: 0.5))
      case .CMYKA:
      self.horizontalColour = Color.fromValues(horizontal.valuesInCMYK)
      self.verticalColour = Color.fromValues(vertical.valuesInCMYK)
      self.blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInCMYK, colour2: vertical.valuesInCMYK, alpha: 0.5))
    case .greyscale:
      self.horizontalColour = Color.white
      self.verticalColour = Color(white: 1, opacity: 0)
      self.blendedColour = Color(white: 1, opacity: 0.5)
    }
    
  }
  
  func horizontalGradient() -> Gradient {
    if horizontal == .brightness {
      return Gradient(colors: [])
    }
    else if horizontal == .saturation {
      return Gradient(colors: [])
    }
    else if horizontal == .hue {
      return Gradient(colors: horizontal.colours)
    }
    else {
      return Gradient(colors: [verticalColour, blendedColour])
    }
  }
  
  func verticalGradient() -> Gradient {
    if vertical == .brightness {
      return Gradient(colors: [])
    }
    else if vertical == .saturation {
      return Gradient(colors: [])
    }
    else if vertical == .hue {
      return Gradient(colors: vertical.colours)
    }
    else {
      return Gradient(colors: [verticalColour, blendedColour])
    }
  }
  
  var body: some View {
    ZStack {
      if horizontal != .alpha && vertical != .alpha && horizontal != .brightness && vertical != .brightness {
        Color.white
      }
      else if horizontal.colourSpace == .HSBA {
        Color.black
      }
      //Horizontal gradient
      // - Start at vertical colour
      // - End at blend of both
      LinearGradient(gradient:  horizontalGradient(), startPoint: .leading, endPoint: .trailing)
        .mask (//Mask top to bottom to make vertical gradient visible
          LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .top, endPoint: .bottom)
      )
      //Horizontal gradient
      // - Start at horizontal colour
      // - End at blend of both
      LinearGradient(gradient: verticalGradient(), startPoint: .top, endPoint: .bottom)
      .mask (//Mask left tor ight to make horizontal gradient visible
        LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .trailing, endPoint: .leading)
      )
    }
  }
}

struct DoubleGradientView_Previews: PreviewProvider {
    static var previews: some View {
      DoubleGradientView(horizontal: .hue, vertical: .brightness)
        .aspectRatio(1, contentMode: .fit)
    }
}
