//  BidirectionalDragModifier.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

extension View {
    /** A way to use BidirectionalDragModifier without using .modifier(BidirectionalDragModifier()) syntax
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

/// A modifier for dragging in two dimensions on CanvasView
struct BidirectionalDragModifier: ViewModifier {
    init(offset: Binding<CGPoint>, xValue: Binding<Double>, yValue: Binding<Double>, size: CGSize) {
        maxX = size.width - 25
        maxY = size.height - 25
        _xValue = xValue
        _yValue = yValue
        _offset = offset
    }

    @Binding var offset: CGPoint
    @Binding var xValue: Double
    @Binding var yValue: Double
    let maxX: CGFloat
    let maxY: CGFloat
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in

                    self.offset.x = value.location.x
                        .clampFromZero(to: self.maxX)
                    self.offset.y = value.location.y
                        .clampFromZero(to: self.maxY)
                    self.xValue = Double(self.offset.x / self.maxX)
                        .clampFromZero(to: 1)
                    self.yValue = Double(self.offset.y / self.maxY)
                        .clampFromZero(to: 1)
      })
    }
}
