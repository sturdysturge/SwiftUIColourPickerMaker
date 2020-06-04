//
//  ContentView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 28/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var data = ColourModel(colourSpace: .HSBA)
  
    var body: some View {
      VStack {
        PreviewColourView(colour: data.colour, square: true)
        WheelView(values: data.valuesInHSBA, angularGradient: .hue, radialGradient: Gradient(colors: [.white, Color(white: 1, opacity: 0.2), .clear]), rotation: $data.valuesInHSBA.hue, distanceFromCentre: $data.valuesInHSBA.saturation)
  }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
