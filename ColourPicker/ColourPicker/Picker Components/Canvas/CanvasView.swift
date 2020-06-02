//
//  CanvasView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 01/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct CanvasView<T>: View, CanvasPickable {
  func getHue() -> Double? {
    if let values = values as? ColourModel.HSBAValues {
      return values.hue
    }
    else {
      return nil
    }
  }
  
  let values: T
  
  let parameters: (Parameter, Parameter)
  
  @Binding var xValue: Double
  @Binding var yValue: Double
  
  func bindingValues() -> (Binding<Double>, Binding<Double>) {
    return ($xValue, $yValue)
  }
    
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
      CanvasView(values: (red: 0, blue: 0, green: 0, alpha: 0), parameters: (.red, .blue), xValue: .constant(0.5), yValue: .constant(0.5))
    }
}


