//
//  CanvasView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 01/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

/// A View that shows data from CanvasData in the body in CanvasPickable
struct CanvasView<T>: View, CanvasPickable {
    let data: CanvasData<T>
}

/// A way to use an ObservedObject in CanvasView_Previews
struct PreviewCanvasView: View {
    @ObservedObject var data = ColourModel(colourSpace: .RGBA)

    var body: some View {
        VStack {
            PreviewColourView(colour: data.colour, square: true)
            CanvasView(data: CanvasData(parameters: (.hue, .saturation), values: $data.valuesInHSBA))
        }
    }
}

/// Previews for CanvasView that use an ObservedObject
struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewCanvasView()
    }
}
