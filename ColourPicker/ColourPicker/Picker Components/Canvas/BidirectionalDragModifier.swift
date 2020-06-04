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
                    } else if self.offset.x > self.size.width - 25 {
                        self.offset.x = self.size.width - 25
                        self.xValue = 1
                    } else {
                        self.xValue = Double(self.offset.x / (self.size.width - 25))
                    }
                    if self.offset.y < 0 {
                        self.offset.y = 0
                        self.yValue = 0
                    } else if self.offset.y > self.size.height - 25 {
                        self.offset.y = self.size.height - 25
                        self.yValue = 1
                    } else {
                        self.yValue = Double(self.offset.y / (self.size.height - 25))
                    }
      })
            .offset(x: offset.x, y: offset.y)
    }
}
