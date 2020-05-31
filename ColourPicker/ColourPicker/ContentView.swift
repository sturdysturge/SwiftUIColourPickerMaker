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
        CMYKAPaletteView(xValue: $data.valuesInCMYKA.cyan, yValue: $data.valuesInCMYKA.magenta, horizontal: .cyan, vertical: .magenta, constants: data.valuesInCMYKA, horizontalSwatches: 10, verticalSwatches: 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
