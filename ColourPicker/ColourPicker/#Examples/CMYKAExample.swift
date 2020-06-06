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
    let sliderOrientation = Axis.horizontal
}

extension CMYKAExample {
    var body: some View {
        VStack {
            PreviewColourView(colour: data.colour, square: false)
                .frame(height: 150)
            ScrollView(.vertical) {
                VStack {
                    SliderView(value: $data.valuesInCMYKA.yellow, parameter: .yellow, orientation: sliderOrientation, thickness: 50, length: 300)
                    SliderView(value: $data.valuesInCMYKA.black, parameter: .black, orientation: sliderOrientation, thickness: 50, length: 300)
                    SliderView(value: $data.valuesInCMYKA.alpha, parameter: .alpha, orientation: sliderOrientation, thickness: 50, length: 300)
                }
                .padding()
            }
        }
    }
}

struct CMYKAExample_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
