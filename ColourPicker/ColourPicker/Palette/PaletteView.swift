//
//  PaletteView2.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct PaletteView<T>: View, PalettePickable where T: PaletteDataStorable {
  var _$xValue: Binding<Double> { _xValue }
  
  var _$yValue: Binding<Double> { _yValue }
  
  let data: T
  @Binding var xValue: Double
  @Binding var yValue: Double
  
  func setValues(xValue: Double, yValue: Double) {
    self.xValue = xValue
    self.yValue = yValue
  }
}

struct PaletteView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
