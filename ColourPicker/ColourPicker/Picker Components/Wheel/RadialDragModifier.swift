//
//  RadialDragModifier.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

public struct RadialDragModifier: ViewModifier {
    init(rotation: Binding<Double>, distanceFromCentre: Binding<Double>, size: CGSize) {
      _rotation = rotation
      _distanceFromCentre = distanceFromCentre
        self.size = size
    }

  @State var offset = CGPoint()
    @Binding var rotation: Double
    @Binding var distanceFromCentre: Double
    let size: CGSize

    public func body(content: Content) -> some View {
        content
          .onAppear {
            self.offset = CGPoint(x: (self.size.width / 2) - 12.5, y: (self.size.height / 2) - 12.5)
          }
            .gesture(DragGesture(minimumDistance: 0)
              
                .onChanged { value in
                    self.offset.x += value.location.x - value.startLocation.x
                    self.offset.y += value.location.y - value.startLocation.y

                    let centre = CGPoint(x: (self.size.width / 2) - 12.5, y: (self.size.height / 2) - 12.5)
                  
                    let angleOfPoint = centre.angleToPoint(self.offset)
                    self.rotation = Double(angleOfPoint / CGFloat.doublePi)
                  
                  
                  let radius = (self.size.width / 2) - 12.5
                  self.distanceFromCentre = Double(sqrt(pow(self.offset.x - radius, 2) + pow(self.offset.y - radius, 2)) / radius)
                  print(self.distanceFromCentre)
                  
                  if self.distanceFromCentre > 1 {
                    //furthestPossible point
                    self.offset.x = centre.x + radius * cos(angleOfPoint)
                    self.offset.y = centre.y + radius * sin(angleOfPoint)
                    self.distanceFromCentre = 1
                  }

      })
            .offset(x: offset.x, y: offset.y)
    }
}
