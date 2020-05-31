//
//  ContentView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 28/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var data = ColourModel(colourSpace: .CMYKA)
    var body: some View {
        VStack {
          PreviewColourView(colour: data.colour, square: true)
          PaletteView(data: CMYKAPaletteData(constants: $data.valuesInCMYKA, horizontal: .cyan, vertical: .magenta, horizontalSwatches: 10, verticalSwatches: 10), xValue: $data.valuesInCMYKA.cyan, yValue: $data.valuesInCMYKA.magenta)
          Slider(value: $data.valuesInCMYKA.yellow, in: 0...1)
          Slider(value: $data.valuesInCMYKA.black, in: 0...1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
