//
//  WheelView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct RGBAWheelView: WheelPickable {
    typealias DataType = RGBAData
    let backgroundColour: Color
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let angularGradient: Gradient
    let radialGradient: Gradient
    init(data: DataType) {
        self.data = data
        angularGradient = data.parameters.0.gradient
        radialGradient = data.parameters.1.gradient
        backgroundColour = .getBackgroundColour(parameters: data.parameters)
    }
}

struct HSBAWheelView: WheelPickable {
    typealias DataType = HSBAData
    let backgroundColour: Color
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let angularGradient: Gradient
    let radialGradient: Gradient
    init(data: DataType) {
        self.data = data
        angularGradient = data.parameters.0.gradient
        radialGradient = data.parameters.1.gradient
        backgroundColour = .getBackgroundColour(parameters: data.parameters)
    }
}

struct CMYKAWheelView: WheelPickable {
    typealias DataType = CMYKAData
    let backgroundColour: Color
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let angularGradient: Gradient
    let radialGradient: Gradient
    init(data: DataType) {
        self.data = data
        angularGradient = data.parameters.0.gradient
        radialGradient = data.parameters.1.gradient
        backgroundColour = .getBackgroundColour(parameters: data.parameters)
    }
}

struct GreyscaleWheelView: WheelPickable {
    typealias DataType = GreyscaleData
    let backgroundColour: Color
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let angularGradient: Gradient
    let radialGradient: Gradient
    init(data: DataType) {
        self.data = data
        angularGradient = data.parameters.0.gradient
        radialGradient = data.parameters.1.gradient
        backgroundColour = .getBackgroundColour(parameters: data.parameters)
    }
}

struct PreviewWheelView: View {
    @ObservedObject var data = ColourModel(colourSpace: .RGBA)
}

extension PreviewWheelView {
    var body: some View {
        VStack {
            PreviewColourView(colour: data.colour, square: true)
        }
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
