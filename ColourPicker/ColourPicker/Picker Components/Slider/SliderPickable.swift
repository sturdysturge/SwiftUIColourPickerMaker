//
//  SliderPickable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 02/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol SliderPickable: View {
    var parameter: Parameter { get }
    var orientation: Axis { get }
    var value: Double { get set }
    var _$value: Binding<Double> { get }
    var thickness: CGFloat { get }
    var length: CGFloat { get }
    var thumbOffset: CGPoint { get }
    var _$thumbOffset: Binding<CGPoint> { get }
    func size(in direction: Axis) -> CGFloat
}

extension SliderPickable {
    func size(in direction: Axis) -> CGFloat {
        if orientation == direction {
            return length
        } else {
            return thickness
        }
    }

    var body: some View {
        ZStack {
            if self.parameter == .alpha {
                TransparencyCheckerboardView()
                    .frame(width: size(in: .horizontal), height: size(in: .vertical), alignment: .center)
                    .cornerRadius(thickness / 4)
            } else {
                Color.white
                    .frame(width: size(in: .horizontal), height: size(in: .vertical), alignment: .center)
            }
            self.parameter.linearGradient(axis: orientation)
                .frame(width: size(in: .horizontal), height: size(in: .vertical), alignment: .center)
                .cornerRadius(thickness / 4)
                .drag(value: self._$value, offset: self._$thumbOffset, length: length, orientation: orientation)
            SliderThumbView(orientation: orientation)
                .offset(x: self.thumbOffset.x, y: self.thumbOffset.y)
        }
        .padding()
    }
}
