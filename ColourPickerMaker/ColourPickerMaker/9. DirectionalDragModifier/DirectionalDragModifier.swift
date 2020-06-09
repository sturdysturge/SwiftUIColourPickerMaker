//  DirectionalDragModifier.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

extension View {
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
}

struct DirectionalDragModifier {
    init(value: Binding<Double>, offset: Binding<CGPoint>, length: CGFloat, orientation: Axis) {
        max = length - 10
        _value = value
        self.orientation = orientation
        _offset = offset
        _offset.wrappedValue = CGPoint(x: orientation == .horizontal ? value.wrappedValue : 0, y: orientation == .horizontal ? 0 : value.wrappedValue)
    }

    @Binding var offset: CGPoint
    @Binding var value: Double
    let max: CGFloat
    let orientation: Axis
}

extension DirectionalDragModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if self.orientation == .horizontal {
                        self.offset.x = value.location.x
                            .clampFromZero(to: self.max)
                        self.value = Double(self.offset.x / self.max)
                            .clampFromZero(to: 1)
                    } else {
                        self.offset.y = value.location.y
                            .clampFromZero(to: self.max)
                        self.value = Double(self.offset.y / self.max)
                            .clampFromZero(to: 1)
                    }
      })
    }
}
