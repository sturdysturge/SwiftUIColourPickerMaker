//
//  BidirectionalDragModifier.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 01/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

/// A modifier for dragging in two dimensions on CanvasView
struct BidirectionalDragModifier: ViewModifier {
    init(xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) {
        maxX = size.width - 25
        maxY = size.height - 25
        _xValue = xValue
        _yValue = yValue
    }

    @State var offset = CGPoint(x: 0, y: 0)
    @Binding var xValue: Double
    @Binding var yValue: Double
    let maxX: CGFloat
    let maxY: CGFloat
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in

                    self.offset.x += (value.location.x - value.startLocation.x)
                        .clampBetweenZero(andMax: self.maxX)
                    self.offset.y += (value.location.y - value.startLocation.y)
                        .clampBetweenZero(andMax: self.maxY)
                    self.xValue = Double(self.offset.x / self.maxX)
                        .clampBetweenZero(andMax: 1)
                    self.yValue = Double(self.offset.y / self.maxY)
                        .clampBetweenZero(andMax: 1)
      })
            .offset(x: offset.x, y: offset.y)
    }
}
