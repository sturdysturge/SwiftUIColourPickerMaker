//
//  Extension.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 21/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

public extension Color {
  static let indigo = Color(red: 0.29, green: 0, blue: 0.5)
  static let violet = Color(red: 0.93, green: 0.5, blue: 0.93)
  #if os(macOS)
  static let background = Color(NSColor.windowBackgroundColor)
  #else
  static let background = Color(UIColor.systemBackgroundColor)
  #endif
}

public extension UnitPoint {
  var opposite: UnitPoint {
    switch self {
    case .bottom: return .top
    case .bottomLeading: return .topTrailing
    case .bottomTrailing: return .topLeading
    case .leading: return .trailing
    case .top: return .bottom
    case .topLeading: return .bottomTrailing
    case .topTrailing: return .bottomLeading
    case .trailing: return .leading
    default:
      fatalError("Direction for \(self) unknown")
    }
  }
}

public extension View {
  func horizontalDrag(value: Binding<Double>, width: CGFloat) -> some View {
    return modifier(HorizontalSlider(value: value, width: width))
  }
  
  func bidirectionalDrag(xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) -> some View {
    return modifier(BidirectionalSlider(xValue: xValue, yValue: yValue, size: size))
  }
  
  func radialDrag(xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) -> some View {
    return modifier(RadialSlider(xValue: xValue, yValue: yValue, size: size))
  }
}

public extension LinearGradient {
  
  static func fromColours(_ colours: [Color], startPoint: UnitPoint) -> LinearGradient {
    return LinearGradient(gradient: Gradient(colors: colours), startPoint: startPoint, endPoint: startPoint.opposite)
  }
  
}

struct  Extension_Previews: PreviewProvider {
  
  public static var previews: some View {
    PreviewView()
  }
}
