//
//  ContentView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 28/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI
struct ColourData<T>: ColourDataStorable {
  typealias ValueType = T
  let constants: T
  let horizontal: Parameter
  let vertical: Parameter
  let horizontalSwatches: Int
  let verticalSwatches: Int
}
struct ContentView: View {
   @ObservedObject var data = ColourModel(colourSpace: .CMYKA)
    var body: some View {
        VStack {
          PreviewColourView(colour: data.colour, square: true)
          NewPalette(data: ColourData(constants: data.valuesInCMYKA, horizontal: .cyan, vertical: .magenta, horizontalSwatches: 10, verticalSwatches: 10), xValue: $data.valuesInCMYKA.cyan, yValue: $data.valuesInCMYKA.magenta)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
