//
//  RadialDragModifier.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

public struct RadialDragModifier: ViewModifier {
  
  @Binding var offset: CGPoint
  @Binding var rotation: Double
  @Binding var distanceFromCentre: Double
  let size: CGSize
  @State var startedDragging = false
  public func body(content: Content) -> some View {
    content
      .onAppear {
        self.offset = CGPoint(x: (self.size.width / 2) - 12.5, y: (self.size.height / 2) - 12.5)
    }
    .gesture(DragGesture(minimumDistance: 0)
    .onChanged { value in
      
      let centre = CGPoint(x: (self.size.width / 2) - 12.5, y: (self.size.height / 2) - 12.5)
      
      self.offset.x = value.location.x
      self.offset.y = value.location.y
      
      let angleOfPoint = centre.angleToPoint(self.offset)
      self.rotation = Double(angleOfPoint / CGFloat.doublePi)
      
      
      let radius = (self.size.width / 2) - 12.5
      self.distanceFromCentre = Double(sqrt(pow(self.offset.x - radius, 2) + pow(self.offset.y - radius, 2)) / radius)
      
      if self.distanceFromCentre > 1 {
        //furthestPossible point
        self.offset.x = centre.x + radius * cos(angleOfPoint - CGFloat.halfPi)
        self.offset.y = centre.y + radius * sin(angleOfPoint - CGFloat.halfPi)
        self.distanceFromCentre = 1
      }
      print(self.offset)
    }
    .onEnded {_ in
      self.startedDragging = false
    })
  }
}
