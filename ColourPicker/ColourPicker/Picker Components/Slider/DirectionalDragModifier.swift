//
//  DirectionalDragModifier.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct DirectionalDragModifier: ViewModifier {
  init(value: Binding<Double>, length: CGFloat, orientation: Axis) {
    self.max = length - 10
    self._value = value
    self.orientation = orientation
    offset = CGPoint(x: orientation == .horizontal ? value.wrappedValue : 0, y: orientation == .horizontal ? 0 : value.wrappedValue)
  }
  
  @State var offset = CGPoint()
  @Binding var value: Double
  let max: CGFloat
  let orientation: Axis
  func body(content: Content) -> some View {
    content
      .gesture(DragGesture(minimumDistance: 0)
        .onChanged { value in
          if self.orientation == .horizontal {
            self.offset.x += (value.location.x - value.startLocation.x)
              .clampBetweenZero(andMax: self.max)
            self.value = Double(self.offset.x / self.max)
              .clampBetweenZero(andMax: 1)
          } else {
            self.offset.y += value.location.y - value.startLocation.y
              .clampBetweenZero(andMax: self.max)
            self.value = Double(self.offset.y / self.max)
              .clampBetweenZero(andMax: 1)
          }
      })
      .offset(x: offset.x, y: offset.y)
  }
}
