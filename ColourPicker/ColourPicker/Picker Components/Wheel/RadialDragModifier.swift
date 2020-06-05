//
//  RadialDragModifier.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct RadialDragModifier: ViewModifier {
    init(offset: Binding<CGPoint>, rotation: Binding<Double>, distanceFromCentre: Binding<Double>, size: CGSize) {
        centre = CGPoint(x: (size.width / 2) - 12.5, y: (size.height / 2) - 12.5)
        _offset = offset
        _rotation = rotation
        radius = centre.x
        _offset.wrappedValue = centre
        _distanceFromCentre = distanceFromCentre
    }

    @Binding var offset: CGPoint
    @Binding var rotation: Double
    @Binding var distanceFromCentre: Double
    let centre: CGPoint
    let radius: CGFloat

    func body(content: Content) -> some View {
        content
            .onAppear {
                self.offset = self.centre
            }
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in

                    self.offset.x = value.location.x
                    self.offset.y = value.location.y

                    let angleOfPoint = self.centre.angleToPoint(self.offset)
                    self.rotation = Double(angleOfPoint / CGFloat.doublePi)
                        .clampBetweenZero(andMax: 1)

                    let distance = self.centre.distanceToPoint(otherPoint: self.offset)
                    self.distanceFromCentre = Double(distance / self.radius)
                        .clampBetweenZero(andMax: 1)

                    if self.distanceFromCentre == 1 {
                        // furthest possible point on the circle
                        self.offset.x = self.centre.x + self.radius * cos(angleOfPoint - CGFloat.halfPi)
                        self.offset.y = self.centre.y + self.radius * sin(angleOfPoint - CGFloat.halfPi)
                    }
    })
    }
}
