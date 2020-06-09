//  SliderView.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

struct RGBASliderView: SliderPickable {
    typealias DataType = RGBASliderData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let thickness: CGFloat
    let length: CGFloat
}

struct HSBASliderView: SliderPickable {
    typealias DataType = HSBASliderData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let thickness: CGFloat
    let length: CGFloat
}

struct CMYKASliderView: SliderPickable {
    typealias DataType = CMYKASliderData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let thickness: CGFloat
    let length: CGFloat
}

struct GreyscaleSliderView: SliderPickable {
    typealias DataType = GreyscaleSliderData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let thickness: CGFloat
    let length: CGFloat
}

struct PreviewSliderView: View {
    @ObservedObject var data = ColourModel(colourSpace: .RGBA)
    var body: some View {
        RGBASliderView(data: RGBASliderData(values: $data.valuesInRGBA, parameter: .red, orientation: .horizontal), thickness: 50, length: 300)
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSliderView()
    }
}
