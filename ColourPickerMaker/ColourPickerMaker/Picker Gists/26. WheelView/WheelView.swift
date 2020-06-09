import SwiftUI

struct RGBAWheelView: WheelPickable {
    typealias DataType = RGBAData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let angularGradient: Gradient
    let radialGradient: Gradient
    init(data: DataType) {
        self.data = data
      angularGradient = Gradient.fromValues(data.values, parameter: data.parameters.0)
        radialGradient = Gradient.fromValues(data.values, parameter: data.parameters.1)
    }
}

struct HSBAWheelView: WheelPickable {
    typealias DataType = HSBAData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let angularGradient: Gradient
    let radialGradient: Gradient
    init(data: DataType) {
        self.data = data
      angularGradient = Gradient.fromValues(data.values, parameter: data.parameters.0)
        radialGradient = Gradient.fromValues(data.values, parameter: data.parameters.1)
    }
}

struct CMYKAWheelView: WheelPickable {
    typealias DataType = CMYKAData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let angularGradient: Gradient
    let radialGradient: Gradient
    init(data: DataType) {
        self.data = data
      angularGradient = Gradient.fromValues(data.values, parameter: data.parameters.0)
        radialGradient = Gradient.fromValues(data.values, parameter: data.parameters.1)
    }
}

struct GreyscaleWheelView: WheelPickable {
    typealias DataType = GreyscaleData
    let data: DataType
    @State var thumbOffset = CGPoint()
    var _$thumbOffset: Binding<CGPoint> { $thumbOffset }
    let angularGradient: Gradient
    let radialGradient: Gradient
    init(data: DataType) {
        self.data = data
      angularGradient = Gradient.fromValues(data.values, parameter: data.parameters.0)
        radialGradient = Gradient.fromValues(data.values, parameter: data.parameters.1)
    }
}

struct PreviewWheelView: View {
    @ObservedObject var data = ColourModel(colourSpace: .HSBA)
  
    var body: some View {
        VStack {
            PreviewColourView(colour: data.colour, square: true)
          HSBAWheelView(data: HSBAData(values: $data.valuesInHSBA, parameters: (.hue, .saturation)))
        }
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWheelView()
    }
}