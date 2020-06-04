//
//  WheelView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct WheelView<T>: View, WheelPickable {
  func getHue() -> Double? {
    if let values = values as? ColourModel.HSBAValues {
      return values.hue
    }
    else {
      return nil
    }
  }
  
  let values: T
  let angularGradient: Gradient
  let radialGradient: Gradient
  @Binding var rotation: Double
  @Binding var distanceFromCentre: Double
  @State var thumbOffset = CGPoint()
  var _$rotation: Binding<Double> { _rotation }
  var _$distanceFromCentre: Binding<Double> { _distanceFromCentre }
  var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
}

protocol WheelPickable {
  func getHue() -> Double?
  associatedtype ValueType
  var values: ValueType { get }
  var angularGradient: Gradient { get }
  var radialGradient: Gradient { get }
  var rotation: Double { get }
  var _$rotation: Binding<Double> { get }
  var distanceFromCentre: Double { get }
  var _$distanceFromCentre: Binding<Double> { get }
  var thumbOffset: CGPoint { get }
  var _$thumbOffset: Binding<CGPoint> { get }
}


extension WheelPickable where Self: View {
  var body: some View {
    ZStack {
      Color(hue: self.getHue() ?? 0, saturation: 1, brightness: 1, opacity: self.getHue() ?? 0)
      GeometryReader { geometry in
        CircleGradientView(angularGradient: self.angularGradient, radialGradient: self.radialGradient, radius: geometry.size.width * 0.7)
          .radialDrag(rotation: self._$rotation, distanceFromCentre: self._$distanceFromCentre, size: geometry.size, offset: self._$thumbOffset)
        Group {
          CircleThumbView()
            .frame(width: 25, height: 25)
            .offset(x: self.thumbOffset.x, y: self.thumbOffset.y)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      }
    }
    .aspectRatio(1, contentMode: .fit)
  }
}



struct WheelView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}



