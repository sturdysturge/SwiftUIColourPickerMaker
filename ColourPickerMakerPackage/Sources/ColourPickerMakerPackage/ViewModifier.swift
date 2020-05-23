//
//  ViewModifier.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 23/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI
@available(iOS 13.0, *)
public struct HorizontalSlider: ViewModifier {
  public init(value: Binding<Double>, width: CGFloat) {
    self.width = width
    self._value = value
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
          }
          else if self.offset.x > self.width - 10 {
            self.offset.x = self.width - 10
            self.value = 1
          }
          else {
            self.value = Double(self.offset.x / (self.width - 10))
          }
      })
      .offset(x: offset.x, y: offset.y)
  }
}
@available(iOS 13.0, *)
public struct RadialSlider: ViewModifier {
  public init(xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) {
    self.size = size
    self._xValue = xValue
    self._yValue = yValue
  }
  
  @State var offset = CGPoint(x: 0, y: 0)
  @Binding var xValue: Double
  @Binding var yValue: Double
  let size: CGSize
  
  func   angleBetweenLines(line1Start: CGPoint, line1End: CGPoint, line2Start: CGPoint, line2End: CGPoint) -> CGFloat {
  let angle1 = atan2(line1Start.y-line1End.y, line1Start.x-line1End.x);
    let angle2 = atan2(line2Start.y-line2End.y, line2Start.x-line2End.x);
  var result = (angle2-angle1) * 180 / 3.14
  if (result<0) {
      result += 360
  }
  return result
  }
  
  public func body(content: Content) -> some View {
    content
      .gesture(DragGesture(minimumDistance: 0)
        .onChanged { value in
          self.offset.x += value.location.x - value.startLocation.x
          self.offset.y += value.location.y - value.startLocation.y
          
          if self.offset.x < 0 {
            self.offset.x = 0
            self.xValue = 0
          }
          else if self.offset.x > self.size.width - 25 {
            self.offset.x = self.size.width - 25
            self.xValue = 1
          }
          else {
            self.xValue = Double(self.offset.x / (self.size.width - 25))
          }
          if self.offset.y < 0 {
            self.offset.y = 0
            self.yValue = 0
          }
          else if self.offset.y > self.size.height - 25 {
            self.offset.y = self.size.height - 25
            self.yValue = 1
          }
          else {
            self.yValue =  Double(self.offset.y / (self.size.height - 25))
          }
          print( self.angleBetweenLines(line1Start: CGPoint(x: self.size.width / 2, y: 0), line1End: CGPoint(x: self.offset.x, y: self.offset.y), line2Start: CGPoint(x: self.size.width / 2, y: 0), line2End: CGPoint(x: self.size.width / 2, y: 10)) - 90)
      })
      .offset(x: offset.x, y: offset.y)
  }
}
@available(iOS 13.0, *)
public struct BidirectionalSlider: ViewModifier {
  public init(xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) {
    self.size = size
    self._xValue = xValue
    self._yValue = yValue
  }
  
  @State var offset = CGPoint(x: 0, y: 0)
  @Binding var xValue: Double
  @Binding var yValue: Double
  let size: CGSize
  public func body(content: Content) -> some View {
    content
      .gesture(DragGesture(minimumDistance: 0)
        .onChanged { value in
          self.offset.x += value.location.x - value.startLocation.x
          self.offset.y += value.location.y - value.startLocation.y
          
          if self.offset.x < 0 {
            self.offset.x = 0
            self.xValue = 0
          }
          else if self.offset.x > self.size.width - 25 {
            self.offset.x = self.size.width - 25
            self.xValue = 1
          }
          else {
            self.xValue = Double(self.offset.x / (self.size.width - 25))
          }
          if self.offset.y < 0 {
            self.offset.y = 0
            self.yValue = 0
          }
          else if self.offset.y > self.size.height - 25 {
            self.offset.y = self.size.height - 25
            self.yValue = 1
          }
          else {
            self.yValue =  Double(self.offset.y / (self.size.height - 25))
          }
      })
      .offset(x: offset.x, y: offset.y)
  }
}
