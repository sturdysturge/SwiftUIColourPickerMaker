//
//  SliderThumbView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 01/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI



struct SliderThumbView: View, ThumbSlidable {
    @Binding var value: Double
    var _$value: Binding<Double> { _value }

    let length: CGFloat

    let orientation: Axis
    func getValueBinding() -> Binding<Double> {
        return $value
    }
}
