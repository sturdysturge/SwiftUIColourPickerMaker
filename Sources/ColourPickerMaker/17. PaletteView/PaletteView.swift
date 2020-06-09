//  PaletteView.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

public struct RGBAPaletteView: PalettePickable {
    public typealias DataType = RGBAData
    public let data: RGBAData
    public let size: (rows: Int, columns: Int)

    public init(data: DataType, rows: Int = 10, columns: Int = 10) {
        self.data = data
        size = (rows: rows, columns: columns)
    }
}

public struct HSBAPaletteView: PalettePickable {
    public typealias DataType = HSBAData
    let data: HSBAData
    let size: (rows: Int, columns: Int)

    public init(data: DataType, rows: Int = 10, columns: Int = 10) {
        self.data = data
        size = (rows: rows, columns: columns)
    }
}

public struct CMYKAPaletteView: PalettePickable {
    public typealias DataType = CMYKAData
    let data: DataType
    let size: (rows: Int, columns: Int)

    public init(data: DataType, rows: Int = 10, columns: Int = 10) {
        self.data = data
        size = (rows: rows, columns: columns)
    }
}

public struct GreyscalePaletteView: PalettePickable {
    public typealias DataType = GreyscaleData
    let data: DataType
    let size: (rows: Int, columns: Int)

    public init(data: DataType, rows: Int = 10, columns: Int = 10) {
        self.data = data
        size = (rows: rows, columns: columns)
    }
}

public struct PreviewPaletteView: View {
    @ObservedObject var data = ColourModel(colourSpace: .HSBA)

  public var body: some View {
        HSBAPaletteView(data: HSBAData(values: $data.valuesInHSBA, parameters: (.hue, .saturation)))
    }
}

struct PaletteView_Previews: PreviewProvider {
  static var previews: some View {
        PreviewPaletteView()
    }
}
