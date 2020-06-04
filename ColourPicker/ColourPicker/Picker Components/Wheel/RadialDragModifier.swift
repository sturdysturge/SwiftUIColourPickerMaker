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
            self.offset = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
          }
            .gesture(DragGesture(minimumDistance: 0)
              
                .onChanged { value in
                    self.offset.x += value.location.x - value.startLocation.x
                    self.offset.y += value.location.y - value.startLocation.y

                    if self.offset.x < 0 {
                        self.offset.x = 0
                        self.rotation = 0
                    } else if self.offset.x > self.size.width - 25 {
                        self.offset.x = self.size.width - 25
                        self.rotation = 1
                    } else {
                        self.rotation = Double(self.offset.x / (self.size.width - 25))
                    }
                    if self.offset.y < 0 {
                        self.offset.y = 0
                        self.distanceFromCentre = 0
                    } else if self.offset.y > self.size.height - 25 {
                        self.offset.y = self.size.height - 25
                        self.distanceFromCentre = 1
                    } else {
                        self.distanceFromCentre = Double(self.offset.y / (self.size.height - 25))
                    }
                    let centre = CGPoint(x: self.size.width / 2, y: self.size.height / 2)

                    
                    let angleOfPoint = centre.angleToPoint(self.offset)
                    self.rotation = Double(angleOfPoint / CGFloat.doublePi)
                    self.distanceFromCentre = Double(centre.distanceToPoint(otherPoint: self.offset) / (self.size.width / 2))
                  print(self.offset)
                  print("distance from centre \(self.distanceFromCentre)")
                  print("angle \(angleOfPoint)")
                  print("rotation \(self.rotation)")
                  print("radius: \(self.size.width / 2)")
                  print("difference: \(CGSize(width: self.offset.x - self.size.width / 2, height: self.offset.y - self.size.height / 2))")
                  
                  
                  let radius = (self.size.width / 2)
                  let distanceToCentre = sqrt(pow(self.offset.x - radius, 2) + pow(self.offset.y - radius, 2))
                  print(distanceToCentre)
                  
                  if distanceToCentre > radius {
                    //furthestPossible point
                   self.offset.x = radius + radius * cos(angleOfPoint)
                   self.offset.y = radius + radius * sin(angleOfPoint)
                  }

      })
            .offset(x: offset.x, y: offset.y)
    }
}
