//
//  WheelView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct WheelView<T>: View, WheelPickable {
  let backgroundColour: Color
  let data: WheelData<T>
  
  @State var thumbOffset = CGPoint()
  var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
}

struct PreviewWheelView: View {
  @ObservedObject var data = ColourModel(colourSpace: .RGBA)
  var body: some View {
    VStack {
      PreviewColourView(colour: data.colour, square: true)
      WheelView(backgroundColour: Color.getBackgroundColour(parameters: (.hue, .saturation)), data: WheelData(rotation: .hue, distanceFromCentre: .saturation, values: $data.valuesInHSBA))
    }
  }
}

struct WheelView_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWheelView()
  }
}



