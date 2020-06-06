//
//  SliderView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct SliderView: SliderPickable {
    @Binding var value: Double
    @State var thumbOffset = CGPoint()
    var _$value: Binding<Double> { _value }
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let parameter: Parameter
    let orientation: Axis
    let thickness: CGFloat
    let length: CGFloat
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Previews.previews
    }
}
