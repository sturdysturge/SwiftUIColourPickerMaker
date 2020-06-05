//
//  PaletteView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct PaletteView<ValueType>: PalettePickable {
    let data: PaletteData<ValueType>
}

struct PreviewPaletteView {
  @ObservedObject var data = ColourModel(colourSpace: .greyscale)
}

extension PreviewPaletteView: View {
  var body: some View {
    PaletteView(data: PaletteData(values: $data.valuesInGreyscale, parameters: (.white, .alpha), size: (rows: 10, columns: 10)))
  }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
