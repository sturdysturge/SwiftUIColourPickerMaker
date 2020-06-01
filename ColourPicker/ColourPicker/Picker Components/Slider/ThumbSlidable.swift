//
//  ThumbSlidable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 02/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol ThumbSlidable {
    var length: CGFloat { get }
    var value: Double { get }
    var _$value: Binding<Double> { get }
    var orientation: Axis { get }
}

extension ThumbSlidable where Self: View {
    var body: some View {
        Group {
            Capsule()
                .stroke(lineWidth: 5)
                .frame(width: self.orientation == .horizontal ? 10 : 70, height: self.orientation == .horizontal ? 70 : 10)
                .drag(value: self._$value, length: length, orientation: orientation)
        }
        .frame(maxWidth: orientation == .horizontal ? .infinity : 70, maxHeight: orientation == .horizontal ? 70 : .infinity, alignment: orientation == .horizontal ? .leading : .top)
    }
}
