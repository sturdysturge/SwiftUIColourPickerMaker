//
//  WheelPickable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol WheelPickable {
  associatedtype ValueType where ValueType: WheelDataStorable
  var data: ValueType { get }
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
      Color(hue: self.data.getHue() ?? 0, saturation: 1, brightness: 1, opacity: self.data.getHue() ?? 0)
        .clipShape(Circle())
      GeometryReader { geometry in
        CircleGradientView(angularGradient: self.data.angularGradient, radialGradient: self.data.radialGradient, radius: geometry.size.width * 0.7)
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
