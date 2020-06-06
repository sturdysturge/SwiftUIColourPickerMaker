//
//  WheelPickable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol WheelPickable: View {
    associatedtype DataType where DataType: ColourDataStorable
    var data: DataType { get }
    var thumbOffset: CGPoint { get }
    var _$thumbOffset: Binding<CGPoint> { get }
    var angularGradient: Gradient { get }
    var radialGradient: Gradient { get }
}

extension WheelPickable {
    var body: some View {
        ZStack {
          data.getBackground()
                .clipShape(Circle())
            GeometryReader { geometry in
                CircleGradientView(angularGradient: self.angularGradient, radialGradient: self.radialGradient, radius: geometry.size.width * 0.7)
                    .radialDrag(rotation: self.data.bindingValues().0, distanceFromCentre: self.data.bindingValues().1, size: geometry.size, offset: self._$thumbOffset)
                Group {
                    CircleThumbView(size: 25)
                        .frame(width: 25, height: 25)
                        .offset(x: self.thumbOffset.x, y: self.thumbOffset.y)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
