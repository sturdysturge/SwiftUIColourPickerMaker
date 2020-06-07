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
  let data: RGBAData
  let size: (rows: Int, columns: Int)
  
  init(data: DataType, rows: Int = 10, columns: Int = 10) {
    self.data = data
    self.size = (rows: rows, columns: columns)
  }
  
}

struct HSBAPaletteView: PalettePickable {
  typealias DataType = HSBAData
  let data: HSBAData
  let size: (rows: Int, columns: Int)
  
  init(data: DataType, rows: Int = 10, columns: Int = 10) {
    self.data = data
    self.size = (rows: rows, columns: columns)
  }
}

struct CMYKAPaletteView: PalettePickable {
  typealias DataType = CMYKAData
  let data: DataType
  let size: (rows: Int, columns: Int)
  
  init(data: DataType, rows: Int = 10, columns: Int = 10) {
    self.data = data
    self.size = (rows: rows, columns: columns)
  }
}

struct GreyscalePaletteView: PalettePickable {
  typealias DataType = GreyscaleData
  let data: DataType
  let size: (rows: Int, columns: Int)
  
  init(data: DataType, rows: Int = 10, columns: Int = 10) {
    self.data = data
    self.size = (rows: rows, columns: columns)
  }
}

struct PreviewPaletteView: View {
  @ObservedObject var data = ColourModel(colourSpace: .HSBA)
  var body: some View {
    VStack {
      PreviewColourView(colour: data.colour, square: true)
    HSBAPaletteView(data: HSBAData(values: $data.valuesInHSBA, parameters: (.hue, .saturation)), rows: 12, columns: 12)
    }
  }
}

struct PaletteView_Previews: PreviewProvider {
  static var previews: some View {
    PreviewPaletteView()
  }
}
