//
//  SliderThumbView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 01/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct SliderThumbView {
  let orientation: Axis
  let width: CGFloat
  let height: CGFloat
  let containerWidth: CGFloat
  let containerHeight: CGFloat
  let containerAlignment: Alignment
  init(orientation: Axis) {
    self.orientation = orientation
    self.width = self.orientation == .horizontal ? 15 : 70
    self.height = self.orientation == .horizontal ? 70 : 15
    self.containerWidth = orientation == .horizontal ? .infinity : 70
    self.containerHeight = orientation == .horizontal ? 70 : .infinity
    self.containerAlignment = orientation == .horizontal ? .leading : .top
  }
}

extension SliderThumbView: View {
  var body: some View {
    ZStack {
      Capsule()
        .stroke(lineWidth: 10)
        .foregroundColor(.white)
        .frame(width: self.width, height: self.height)
      Capsule()
        .stroke(lineWidth: 5)
        .foregroundColor(.black)
        .frame(width: self.width, height: self.height)
    }
    .frame(maxWidth: self.containerWidth, maxHeight: self.containerHeight, alignment: self.containerAlignment)
  }
}
