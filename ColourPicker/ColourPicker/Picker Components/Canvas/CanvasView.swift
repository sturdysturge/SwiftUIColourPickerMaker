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
  @State var thumbOffset = CGPoint()
  var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let data: CanvasData<T>
}

/// A way to use an ObservedObject in CanvasView_Previews
struct PreviewCanvasView {
    @ObservedObject var data = ColourModel(colourSpace: .greyscale)
}
extension PreviewCanvasView: View {
    var body: some View {
        VStack {
            PreviewColourView(colour: data.colour, square: true)
            CanvasView(data: CanvasData(parameters: (.white, .alpha), values: $data.valuesInGreyscale))
        }
    }
}

/// Previews for CanvasView that use an ObservedObject
struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
