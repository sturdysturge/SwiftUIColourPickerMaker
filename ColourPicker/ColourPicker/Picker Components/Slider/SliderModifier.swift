//
//  HorizontalSlider.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

public struct DirectionalDragModifier: ViewModifier {
    public init(value: Binding<Double>, length: CGFloat, orientation: Axis) {
        self.length = length
        _value = value
        self.orientation = orientation
        offset = CGPoint(x: orientation == .horizontal ? value.wrappedValue : 0, y: orientation == .horizontal ? 0 : value.wrappedValue)
    }

    @State var offset = CGPoint()
    @Binding var value: Double
    let length: CGFloat
    let orientation: Axis
    public func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if self.orientation == .horizontal {
                        self.offset.x += value.location.x - value.startLocation.x

                        if self.offset.x < 0 {
                            self.offset.x = 0
                            self.value = 0
                        } else if self.offset.x > self.length - 10 {
                            self.offset.x = self.length - 10
                            self.value = 1
                        } else {
                            self.value = Double(self.offset.x / (self.length - 10))
                        }
                    } else {
                        self.offset.y += value.location.y - value.startLocation.y

                        if self.offset.y < 0 {
                            self.offset.y = 0
                            self.value = 0
                        } else if self.offset.y > self.length - 10 {
                            self.offset.y = self.length - 10
                            self.value = 1
                        } else {
                            self.value = Double(self.offset.y / (self.length - 10))
                        }
                    }
      })
            .offset(x: offset.x, y: offset.y)
    }
}
