//
//  WheelView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct WheelView<T>: WheelPickable {
    let backgroundColour: Color
    let data: WheelData<T>
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
}

struct PreviewWheelView: View {
    @ObservedObject var data = ColourModel(colourSpace: .RGBA)
}

  extension PreviewWheelView {
    var body: some View {
        VStack {
            PreviewColourView(colour: data.colour, square: true)
          WheelView(backgroundColour: .clear, data: WheelData(rotation: .white, distanceFromCentre: .alpha, values: $data.valuesInGreyscale))
        }
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
