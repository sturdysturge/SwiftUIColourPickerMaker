//
//  ViewModifier.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 23/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

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
          let centre = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
          
          print(self.offset)
          print(centre.angleToPoint(_ point: self.offset))
          let angleOfPoint = centre.angleToPoint(_ point: self.offset)
          self.xValue = Double(angleOfPoint / CGFloat(Float.doublePi))
          self.yValue = Double(centre.distanceToPoint(otherPoint: self.offset) / (self.size.width / 2))
          
      })
      .offset(x: offset.x, y: offset.y)
  }
}

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

struct ViewModifier_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
