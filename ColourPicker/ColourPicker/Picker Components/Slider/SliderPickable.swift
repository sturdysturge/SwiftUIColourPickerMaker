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
    func size(in direction: Axis) -> CGFloat
    func getGradient() -> LinearGradient
}

extension SliderPickable {
    func size(in direction: Axis) -> CGFloat {
        if orientation == direction {
            return length
        } else {
            return thickness
        }
    }

    func getGradient() -> LinearGradient {
        return orientation == .horizontal ? parameter.horizontalGradient : parameter.verticalGradient
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
            self.getGradient()
                .frame(width: size(in: .horizontal), height: size(in: .vertical), alignment: .center)
                .cornerRadius(thickness / 4)
            SliderThumbView(value: self._$value, length: size(in: orientation), orientation: self.orientation)
        }
        .padding()
    }
}
