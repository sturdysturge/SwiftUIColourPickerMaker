//
//  WheelView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct WheelView<T>: View, WheelPickable where T: WheelDataStorable {
  typealias ValueType = T
  
  internal init(data: T) {
    self.data = data
    self.backgroundColour = .getBackgroundColour(parameters: (data.rotation, data.distanceFromCentre))
    self._rotation = data.getBindingValue(for: data.rotation)
    self._distanceFromCentre = data.getBindingValue(for: data.distanceFromCentre)
  }
  
  
  let backgroundColour: Color
  let data: ValueType
  @Binding var rotation: Double
  @Binding var distanceFromCentre: Double
  @State var thumbOffset = CGPoint()
  var _$rotation: Binding<Double> { _rotation }
  var _$distanceFromCentre: Binding<Double> { _distanceFromCentre }
  var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
}

struct WheelView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}



