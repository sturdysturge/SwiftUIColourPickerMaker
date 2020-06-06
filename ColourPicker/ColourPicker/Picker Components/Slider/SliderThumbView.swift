//
//  SliderThumbView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 01/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct SliderThumbView {
    let width: CGFloat
    let height: CGFloat
    let containerWidth: CGFloat
    let containerHeight: CGFloat
    let containerAlignment: Alignment

  init(orientation: Axis, length: CGFloat = 70, thickness: CGFloat = 15) {
        let isHorizontal = orientation == .horizontal
        width = isHorizontal ? thickness : length
        height = isHorizontal ? length : thickness
        containerWidth = isHorizontal ? .infinity : length
        containerHeight = isHorizontal ? length : .infinity
        containerAlignment = isHorizontal ? .leading : .top
    }
}

extension SliderThumbView: View {
    var body: some View {
        ZStack {
            Capsule()
                .stroke(lineWidth: 10)
                .foregroundColor(.white)
                .frame(width: self.width, height: self.height)
            Capsule()
                .stroke(lineWidth: 5)
                .foregroundColor(.black)
                .frame(width: self.width, height: self.height)
        }
        .frame(maxWidth: self.containerWidth, maxHeight: self.containerHeight, alignment: self.containerAlignment)
    }
}
