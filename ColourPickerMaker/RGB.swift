//
//  RGB.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 21/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

enum RGBCanvasType {
  case redGreen,
  redBlue,
  redAlpha,
  greenRed,
  greenBlue,
  greenAlpha,
  blueRed,
  blueGreen,
  blueAlpha,
  alphaRed,
  alphaGreen,
  alphaBlue
  
  var gradients: some View {
    return RGBDoubleGradientView(type: self)
  }
  
}

struct RGBDoubleGradientView: View {
  let type: RGBCanvasType
  var body: some View {
    ZStack {
      GridBackgroundView()
      if type == .redGreen {
        GradientType.red.vertical
        GradientType.green.horizontal
        GradientType.yellow.diagonal
      }
      else if type == .redBlue {
        GradientType.red.vertical
        GradientType.blue.horizontal
        GradientType.purple.diagonal
      }
      else if type == .redAlpha {
        GradientType.red.horizontal
          .mask (
            GradientType.alpha.vertical
        )
        
      }
      else if type == .greenRed {
        GradientType.red.horizontal
        GradientType.green.vertical
        GradientType.yellow.diagonal
      }
      else if type == .greenBlue {
        GradientType.green.horizontal
        GradientType.blue.vertical
        GradientType.cyan.horizontal
      }
      else if type == .greenAlpha {
        GradientType.green.horizontal
          
          .mask (
            GradientType.alpha.vertical
        )
      }
      else if type == .blueGreen {
        GradientType.blue.horizontal
        GradientType.green.vertical
        GradientType.cyan.diagonal
      }
      else if type == .blueRed {
        GradientType.blue.horizontal
        GradientType.red.vertical
        GradientType.purple.diagonal
      }
      else if type == .blueAlpha {
        GradientType.blue.horizontal
          .mask (
            GradientType.alpha.vertical
        )
      }
      else if type == .alphaRed {
        GradientType.alpha.horizontal
        GradientType.red.vertical
      }
      else if type == .alphaGreen {
        GradientType.alpha.horizontal
        GradientType.green.vertical
      }
      else if type == .alphaBlue {
        GradientType.alpha.vertical
        GradientType.blue.horizontal
      }
    }
  }
}


struct RGBGradientsGridView : View {
  var body: some View {
    VStack {
      Group {
        //Saturation
        HStack {
          ZStack {
            RGBCanvasType.redGreen.gradients
            Text("red green")
          }
          .aspectRatio(1, contentMode: .fit)
          ZStack {
            RGBCanvasType.redBlue.gradients
            Text("red blue")
          }
          .aspectRatio(1, contentMode: .fit)
          ZStack {
            RGBCanvasType.redAlpha.gradients
            Text("red alpha")
          }
          .aspectRatio(1, contentMode: .fit)
        }
        HStack {
          ZStack {
            RGBCanvasType.greenRed.gradients
            Text("green red")
          }
          .aspectRatio(1, contentMode: .fit)
          ZStack {
            RGBCanvasType.greenBlue.gradients
            Text("green blue")
          }
          .aspectRatio(1, contentMode: .fit)
          
          ZStack {
            RGBCanvasType.greenAlpha.gradients
            Text("green alpha")
          }
          .aspectRatio(1, contentMode: .fit)
        }
        HStack {
          ZStack {
            RGBCanvasType.blueRed.gradients
            Text("blue red")
          }
          .aspectRatio(1, contentMode: .fit)
          ZStack {
            RGBCanvasType.blueGreen.gradients
            Text("blue green")
          }
          .aspectRatio(1, contentMode: .fit)
          
          ZStack {
            RGBCanvasType.blueAlpha.gradients
            Text("blue alpha")
          }
          .aspectRatio(1, contentMode: .fit)
        }
      }
      HStack {
        ZStack {
          RGBCanvasType.alphaRed.gradients
          Text("alpha red")
        }
        .aspectRatio(1, contentMode: .fit)
        ZStack {
          RGBCanvasType.alphaGreen.gradients
          Text("alpha green")
        }
        .aspectRatio(1, contentMode: .fit)
        
        ZStack {
          RGBCanvasType.alphaBlue.gradients
          Text("alpha blue")
        }
        .aspectRatio(1, contentMode: .fit)
      }
    }
  }
}
