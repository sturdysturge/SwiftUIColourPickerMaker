//  CanvasPickable.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

protocol CanvasPickable: View {
    associatedtype DataType where DataType: ColourDataBindable
    var data: DataType { get }
    var thumbOffset: CGPoint { get }
    var _$thumbOffset: Binding<CGPoint> { get }
}

extension CanvasPickable {
    var body: some View {
        ZStack {
            data.getBackground()
            GeometryReader { geometry in
                DoubleGradientView(horizontal: self.data.parameters.x, vertical: self.data.parameters.y)
                    .bidirectionalDrag(offset: self._$thumbOffset, xValue: self.data.bindingValues().x, yValue: self.data.bindingValues().y, size: geometry.size)
                CircleThumbView(size: 25)
                    .offset(x: self.thumbOffset.x, y: self.thumbOffset.y)
            }
        }
        .background(TransparencyCheckerboardView())
        .aspectRatio(1, contentMode: .fit)
    }
}
