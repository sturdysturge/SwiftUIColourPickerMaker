//
//  Extension.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 21/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

extension Color {
  static let indigo = Color(red: 0.29, green: 0, blue: 0.5)
  static let violet = Color(red: 0.93, green: 0.5, blue: 0.93)
  static let background = Color(UIColor.systemBackground)
}

extension Axis {
  var start: UnitPoint {
    switch self {
    case .horizontal:
      return .leading
    case .vertical:
      return .top
    }
  }
  
  var end: UnitPoint {
    switch self {
    case .horizontal:
      return .trailing
    case .vertical:
      return .bottom
    }
  }
}

extension View {
  func horizontalDrag(value: Binding<Double>, width: CGFloat) -> some View {
    return modifier(HorizontalSlider(value: value, width: width))
  }
  
  func bidirectionalDrag(xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) -> some View {
    return modifier(BidirectionalSlider(xValue: xValue, yValue: yValue, size: size))
  }
}
