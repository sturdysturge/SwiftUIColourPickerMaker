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
  let horizontalGradient: Gradient
  let verticalGradient: Gradient
  init(horizontal: Parameter, vertical: Parameter) {
    self.horizontal = horizontal
    self.vertical = vertical
    guard horizontal.colourSpace == vertical.colourSpace else {
      fatalError("Colour spaces must be the same")
    }
    let colourSpace = horizontal.colourSpace
    switch colourSpace {
    case .RGBA:
     let horizontalColour = Color.fromValues(horizontal.valuesInRGB)
      let verticalColour = Color.fromValues(vertical.valuesInRGB)
      let blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInRGB, colour2: vertical.valuesInRGB, alpha: 0.5))
      self.horizontalGradient = Gradient(colors: [verticalColour, blendedColour])
      self.verticalGradient = Gradient(colors: [horizontalColour, blendedColour])
      case .HSBA:
        if horizontal == .brightness || horizontal == .saturation {
          self.horizontalGradient = Gradient(colors: [])
        }
        else if horizontal == .hue {
          self.horizontalGradient = .hue
        }
        else {
        
      let verticalColour = Color.fromValues(vertical.valuesInHSB)
      let blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInHSB, colour2: vertical.valuesInHSB, alpha: 0.5))
          self.horizontalGradient = Gradient(colors: [verticalColour, blendedColour])
    }
      if vertical == .brightness || vertical == .saturation {
            self.verticalGradient = Gradient(colors: [])
          }
          else if vertical == .hue {
            self.verticalGradient = .hue
          }
          else {
          let horizontalColour = Color.fromValues(horizontal.valuesInHSB)
        let blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInHSB, colour2: vertical.valuesInHSB, alpha: 0.5))
            self.verticalGradient = Gradient(colors: [horizontalColour, blendedColour])
      }
      case .CMYKA:
      let horizontalColour = Color.fromValues(horizontal.valuesInCMYK)
      let verticalColour = Color.fromValues(vertical.valuesInCMYK)
      let blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInCMYK, colour2: vertical.valuesInCMYK, alpha: 0.5))
      self.horizontalGradient = Gradient(colors: [verticalColour, blendedColour])
      self.verticalGradient = Gradient(colors: [horizontalColour, blendedColour])
    case .greyscale:
      self.horizontalGradient = Gradient(colors: [horizontal == .white ? .black : .clear, .white])
      self.verticalGradient = Gradient(colors: [vertical == .white ? .black : .clear, .white])
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
      LinearGradient(gradient:  horizontalGradient, startPoint: .leading, endPoint: .trailing)
        .mask (//Mask top to bottom to make vertical gradient visible
          LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .top, endPoint: .bottom)
      )
      //Horizontal gradient
      // - Start at horizontal colour
      // - End at blend of both
      LinearGradient(gradient: verticalGradient, startPoint: .top, endPoint: .bottom)
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
