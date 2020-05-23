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
  #if canImport(UIKit)
  static let background = Color(UIColor.systemBackground)
  #else
  static let background = Color(NSColor.windowBackgroundColor)
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
  
  func radialDrag(rotation: Binding<Double>, distanceFromCentre: Binding<Double>, size: CGSize) -> some View {
    return modifier(RadialSlider(rotation: rotation, distanceFromCentre: distanceFromCentre, size: size))
  }
}

public extension LinearGradient {
  
  static func fromColours(_ colours: [Color], startPoint: UnitPoint) -> LinearGradient {
    return LinearGradient(gradient: Gradient(colors: colours), startPoint: startPoint, endPoint: startPoint.opposite)
  }
  
}

extension CGFloat {
  static let halfPi = CGFloat.pi / 2
  static let doublePi = CGFloat.pi * 2
}

extension CGPoint {
    
    func angleToPoint(_ point: CGPoint) -> CGFloat {
        
        let xDistance = point.x - self.x
        let yDistance = point.y - self.y
      var radians = CGFloat.halfPi - atan2(xDistance, yDistance)
        
        while radians < 0 {
          radians += CGFloat.doublePi
        }
        
        return radians
    }
    
    func distanceToPoint(otherPoint: CGPoint) -> CGFloat {
        return sqrt(pow((otherPoint.x - x), 2) + pow((otherPoint.y - y), 2))
    }
}

struct  Extension_Previews: PreviewProvider {
  
  public static var previews: some View {
    PreviewView()
  }
}
