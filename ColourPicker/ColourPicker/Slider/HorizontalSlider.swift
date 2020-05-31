//
//  HorizontalSlider.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

extension View {
  func horizontalDrag(value: Binding<Double>, width: CGFloat) -> some View {
    return modifier(HorizontalSlider(value: value, width: width))
  }
}
public struct HorizontalSlider: ViewModifier {
  public init(value: Binding<Double>, width: CGFloat) {
    self.width = width
    _value = value
  }
  
  @State var offset = CGPoint(x: 0, y: 0)
  @Binding var value: Double
  let width: CGFloat
  
  public func body(content: Content) -> some View {
    content
      .gesture(DragGesture(minimumDistance: 0)
        .onChanged { value in
          self.offset.x += value.location.x - value.startLocation.x
          
          if self.offset.x < 0 {
            self.offset.x = 0
            self.value = 0
          } else if self.offset.x > self.width - 10 {
            self.offset.x = self.width - 10
            self.value = 1
          } else {
            self.value = Double(self.offset.x / (self.width - 10))
          }
      })
      .offset(x: offset.x, y: offset.y)
  }
}
