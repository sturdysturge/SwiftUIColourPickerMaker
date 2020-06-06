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
