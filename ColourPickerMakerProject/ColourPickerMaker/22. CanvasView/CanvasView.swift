//  CanvasView.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

/// A View that shows RGBA data from CanvasData in the body in CanvasPickable
struct RGBACanvasView: CanvasPickable {
    typealias DataType = RGBAData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
}

/// A View that shows HSBA data from CanvasData in the body in CanvasPickable
struct HSBACanvasView: CanvasPickable {
    typealias DataType = HSBAData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
}

/// A View that shows CMYKA data from CanvasData in the body in CanvasPickable
struct CMYKACanvasView: CanvasPickable {
    typealias DataType = CMYKAData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
}

/// A View that shows greyscale data from CanvasData in the body in CanvasPickable
struct GreyscaleCanvasView: CanvasPickable {
    typealias DataType = GreyscaleData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
}

/// A way to preview CanvasView varieties even though they require an ObservableObject
struct PreviewCanvasView: View {
    @ObservedObject var data = ColourModel(colourSpace: .RGBA)
    var body: some View {
        VStack {
            PreviewColourView(colour: data.colour, square: true)
            RGBACanvasView(data: RGBAData(values: $data.valuesInRGBA, parameters: (.red, .green)))
        }
    }
}

/// Previews for CanvasView that use an ObservedObject
struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewCanvasView()
    }
}
