//  SliderView.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

public struct RGBASliderView: SliderPickable {
  public init(data: RGBASliderView.DataType, thickness: CGFloat, length: CGFloat) {
    self.data = data
    self.thickness = thickness
    self.length = length
  }
  
    public typealias DataType = RGBASliderData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let thickness: CGFloat
    let length: CGFloat
}

public struct HSBASliderView: SliderPickable {
  public init(data: HSBASliderView.DataType, thickness: CGFloat, length: CGFloat) {
    self.data = data
    self.thickness = thickness
    self.length = length
  }
  
    public typealias DataType = HSBASliderData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let thickness: CGFloat
    let length: CGFloat
}

public struct CMYKASliderView: SliderPickable {
  public init(data: CMYKASliderView.DataType, thickness: CGFloat, length: CGFloat) {
    self.data = data
    self.thickness = thickness
    self.length = length
  }
  
    public typealias DataType = CMYKASliderData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let thickness: CGFloat
    let length: CGFloat
}

public struct GreyscaleSliderView: SliderPickable {
  public init(data: GreyscaleSliderView.DataType, thickness: CGFloat, length: CGFloat) {
    self.data = data
    self.thickness = thickness
    self.length = length
  }
  
    public typealias DataType = GreyscaleSliderData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let thickness: CGFloat
    let length: CGFloat
}

public struct PreviewSliderView: View {
    @ObservedObject var data = ColourModel(colourSpace: .RGBA)
  public var body: some View {
        RGBASliderView(data: RGBASliderData(values: $data.valuesInRGBA, parameter: .red, orientation: .horizontal), thickness: 50, length: 300)
    }
}

struct SliderView_Previews: PreviewProvider {
  static var previews: some View {
        PreviewSliderView()
    }
}
