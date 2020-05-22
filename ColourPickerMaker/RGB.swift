//
//  RGB.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 21/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

enum RGBCanvasType: String, CaseIterable {
  case redGreen = "red green",
  redBlue = "red blue",
  redAlpha = "red alpha",
  greenRed = "green red",
  greenBlue = "green blue",
  greenAlpha = "green alpha",
  blueRed = "blue red",
  blueGreen = "blue green",
  blueAlpha = "blue alpha",
  alphaRed = "alpha red",
  alphaGreen = "alpha green",
  alphaBlue = "alpha blue"
  
  var gradients: some View {
    return RGBDoubleGradientView(type: self)
  }
  
}

struct RGBDoubleGradientView: View {
  let type: RGBCanvasType
  var body: some View {
    ZStack {
      GridBackgroundView(squareSize: 20)
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


struct RGBGradientsGridView : View, GridPreviewable {
  @EnvironmentObject var colourModel: ColourModel
  let rowSize = 4
  
  var body: some View {
    VStack {
      ForEach(1...numberOfRows(for: RGBCanvasType.allCases.count), id: \.self) { row in
          HStack {
            ForEach(self.getRow(number: row, fromArray: RGBCanvasType.allCases), id: \.self) {
              canvasType in
              ZStack {
              canvasType.gradients
                Text(canvasType.rawValue)
                  .background(Color(UIColor.systemBackground))
              }
              .aspectRatio(1, contentMode: .fit)
            }
        }
      }
    }
  }
}

struct RGB_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
