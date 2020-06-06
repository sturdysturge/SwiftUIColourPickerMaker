//
//  PaletteView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct RGBAPaletteView: PalettePickable {
    typealias DataType = RGBAData
    var data: RGBAData
    var size: (rows: Int, columns: Int)
}

struct HSBAPaletteView: PalettePickable {
    var data: HSBAData
    typealias DataType = HSBAData
    var size: (rows: Int, columns: Int)
}

struct CMYKAPaletteView: PalettePickable {
    var data: CMYKAData
    typealias DataType = CMYKAData
    var size: (rows: Int, columns: Int)
}

struct GreyscalePaletteView: PalettePickable {
    var data: GreyscaleData
    typealias DataType = GreyscaleData
    var size: (rows: Int, columns: Int)
}

struct PreviewPaletteView {
    @ObservedObject var data = ColourModel(colourSpace: .RGBA)
}

extension PreviewPaletteView: View {
    var body: some View {
        VStack {
            PreviewColourView(colour: data.colour, square: true)
            RGBAPaletteView(data: RGBAData(values: $data.valuesInRGBA, parameters: (.red, .green)), size: (rows: 10, columns: 10))
        }
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
