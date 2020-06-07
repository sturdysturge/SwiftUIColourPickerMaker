//
//  Extensions.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 30/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

extension CGFloat {
  static let halfPi: CGFloat = 1.5707963267948966
  static let doublePi: CGFloat = 6.283185307179586
  func clampFrom(_ minValue: CGFloat, to maxValue: CGFloat) -> CGFloat {
    return [[minValue, self].max() ?? self, maxValue].min() ?? self
  }
  
  func clampFromZero(to maxValue: CGFloat) -> CGFloat {
    return [[0, self].max() ?? self, maxValue].min() ?? self
  }
}

extension Double {
  func clampFrom(min minValue: Double, to maxValue: Double) -> Double {
    return [[minValue, self].max() ?? self, maxValue].min() ?? self
  }
  
  func clampFromZero(to maxValue: Double) -> Double {
    return [[0, self].max() ?? self, maxValue].min() ?? self
  }
}

extension CGPoint {
  func angleToPoint(_ point: CGPoint) -> CGFloat {
    let xDistance = point.x - x
    let yDistance = point.y - y
    var radians = CGFloat.halfPi + (CGFloat.halfPi - atan2(xDistance, yDistance))
    
    while radians < 0 {
      radians += CGFloat.doublePi
    }
    
    return radians
  }
  
  func distanceToPoint(otherPoint: CGPoint) -> CGFloat {
    return sqrt(pow(otherPoint.x - x, 2) + pow(otherPoint.y - y, 2))
  }
}

extension Gradient {
  static let hue = Gradient(colors: [.red, .yellow, .green, .blue, .indigo, .violet, .red])
  static let blank = Gradient(colors: [])
  
  static  func canvasGradient(axis: Axis, horizontal: Parameter, vertical: Parameter) -> Gradient {
    switch horizontal.colourSpace {
    case .RGBA:
      let horizontalColour = Color.fromValues(horizontal.valuesInRGB)
      let verticalColour = Color.fromValues(vertical.valuesInRGB)
      let blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInRGB, colour2: vertical.valuesInRGB, alpha: 0.5))
      return axis == .horizontal ?
        Gradient(colors: [verticalColour, blendedColour]) : Gradient(colors: [horizontalColour, blendedColour])
    case .HSBA:
      if axis == .horizontal {
        if horizontal == .brightness || horizontal == .saturation {
          return Gradient(colors: [])
        } else if horizontal == .hue {
          return .hue
        } else {
          return Gradient(colors: [])
        }
      } else { if vertical == .brightness || vertical == .saturation {
        return Gradient(colors: [])
      } else if vertical == .hue {
        return .hue
      } else {
        return Gradient(colors: [])
        }
      }
    case .CMYKA:
      let horizontalColour = Color.fromValues(horizontal.valuesInCMYK)
      let verticalColour = Color.fromValues(vertical.valuesInCMYK)
      let blendedColour = Color.fromValues(Color.blend(colour1: horizontal.valuesInCMYK, colour2: vertical.valuesInCMYK, alpha: 0.5))
      return axis == .horizontal ?
        Gradient(colors: [verticalColour, blendedColour]) : Gradient(colors: [horizontalColour, blendedColour])
    case .greyscale:
      return axis == .horizontal ?
        Gradient(colors: [horizontal == .white ? .black : .clear, .white]) : Gradient(colors: [vertical == .white ? .black : .clear, .white])
    }
  }
}


extension View {
  /**
   A way to use RadialDragModifier without calling it directly
   - Parameters:
   - rotation: A Binding for the angle of the selected point on the circle
   - distanceFromCentre: The radius of the line from the centre to the selected point
   - size: The space the wheel occupies
   - Returns: A View that has dragging functionality
   */
  func radialDrag(rotation: Binding<Double>, distanceFromCentre: Binding<Double>, size: CGSize, offset: Binding<CGPoint>) -> some View {
    return modifier(RadialDragModifier(offset: offset, rotation: rotation, distanceFromCentre: distanceFromCentre, size: size))
  }
  
  /**
   A way to use DirectionalDragModifier without calling it directly
   - Parameters:
   - value: A Binding so that the slider's value changes are passed back
   - length: The length of the slider (horizontally or vertically)
   - orientation: The orientation of the slider (horizontally or vertically)
   - Returns: A View that has dragging functionality
   */
  func drag(value: Binding<Double>, offset: Binding<CGPoint>, length: CGFloat, orientation: Axis) -> some View {
    return modifier(DirectionalDragModifier(value: value, offset: offset, length: length, orientation: orientation))
  }
  
  /** A way to use BidirectionalDragModifier without calling it directly
   - Parameters:
   - offset: The amount that the circular thumb is offset
   - xValue: The value based on horizontal position between 0 and 1
   - yValue: The value based on vertical position between 0 and 1
   - size: The size of the canvas
   - Returns: A View that has bidirectional dragging functionality
   */
  func bidirectionalDrag(offset: Binding<CGPoint>, xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) -> some View {
    return modifier(BidirectionalDragModifier(offset: offset, xValue: xValue, yValue: yValue, size: size))
  }
}
