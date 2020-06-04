//
//  PaletteView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct PaletteView<ValueType>: View, PalettePickable {
    let data: PaletteData<ValueType>
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
