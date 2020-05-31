//
//  CMYKAExample.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct CMYKAExample: View {
  @ObservedObject var data = ColourModel(colourSpace: .CMYKA)
  var body: some View {
    VStack {
      PreviewColourView(colour: data.colour, square: false)
        .frame(height: 150)
      ScrollView(.vertical) {
        VStack {
          PaletteView(data: CMYKAPaletteData(constants: $data.valuesInCMYKA, horizontal: .cyan, vertical: .magenta, horizontalSwatches: 5, verticalSwatches: 10), xValue: $data.valuesInCMYKA.cyan, yValue: $data.valuesInCMYKA.magenta)
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: 500)
          SliderView(parameter: .yellow, value: $data.valuesInCMYKA.yellow, gradient: GradientType.yellow.horizontal)
          SliderView(parameter: .black, value: $data.valuesInCMYKA.black, gradient: GradientType.black.horizontal)
          SliderView(parameter: .alpha, value: $data.valuesInCMYKA.alpha, gradient: GradientType.alpha.horizontal)
        }
        .padding()
      }
    }
  }
}
