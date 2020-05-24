//
//  SharedComponents.swift
//
//
//  Created by Rob Sturgeon on 23/05/2020.
//

import SwiftUI

public struct ColourWheelView: View {
    public init(rotation: Binding<Double>, distanceFromCentre: Binding<Double>, angularGradient: Gradient = Gradient(colors: []), radialGradient: Gradient = Gradient(colors: [])) {
        _rotation = rotation
        _distanceFromCentre = distanceFromCentre
        self.angularGradient = angularGradient
        self.radialGradient = radialGradient
    }

    let angularGradient: Gradient
    let radialGradient: Gradient
    @Binding var rotation: Double
    @Binding var distanceFromCentre: Double
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                AngularGradient(gradient: self.angularGradient, center: .center)
                RadialGradient(gradient: self.radialGradient, center: .center, startRadius: 0, endRadius: geometry.size.width / 2)
                Group {
                    Circle()
                        .stroke(lineWidth: 5)
                        .frame(width: 25, height: 25)
                        .radialDrag(rotation: self.$rotation, distanceFromCentre: self.$distanceFromCentre, size: geometry.size)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

/// A background that can only be seen when Color opacity is less than 1.0
public struct TransparencyCheckerboardView: View {
    /// The size for each white or grey tile
    let tileSize: CGFloat
    /// The first colour to alternate between
    let colour1: Color
    /// The second colour to alternate between
    let colour2: Color

    /// A constructor that allows custom checkerboards
    /// - Parameters:
    ///   - tileSize: A width/height for each tile
    ///   - colour1: The first colour to alternate between
    ///   - colour2: The second colour to alternate between
    public init(tileSize: CGFloat = 20, colour1: Color = .white, colour2: Color = .gray) {
        self.tileSize = tileSize
        self.colour1 = colour1
        self.colour2 = colour2
    }

    /// Calculates what colour each tile should be based on its position
    /// - Parameters:
    ///   - horizontalIndex: How far along the tile is horizontally
    ///   - verticalIndex: How far along the tile is vertically
    /// - Returns: The colour the tile should be
    func squareColour(horizontalIndex: Int, verticalIndex: Int) -> Color {
        if verticalIndex % 2 == 0 {
            return horizontalIndex % 2 == 0 ? .gray : .white
        } else {
            return horizontalIndex % 2 != 0 ? .gray : .white
        }
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(0 ... Int(geometry.size.height / self.tileSize), id: \.self) { verticalIndex in
                    HStack(spacing: 0) {
                        ForEach(0 ... Int(geometry.size.width / self.tileSize), id: \.self) { horizontalIndex in
                            Rectangle()
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(self.squareColour(horizontalIndex: horizontalIndex, verticalIndex: verticalIndex))
                        }
                    }
                }
            }
        }
    }
}

public struct GridPaletteView: View {
    public init(canvasType: HSBCanvasType, verticalSwatches: Int, horizontalSwatches: Int, hue: Binding<Double>, saturation: Binding<Double>, brightness: Binding<Double>, alpha: Binding<Double>) {
        self.canvasType = canvasType
        self.verticalSwatches = verticalSwatches
        self.horizontalSwatches = horizontalSwatches
        _hue = hue
        _saturation = saturation
        _brightness = brightness
        _alpha = alpha
    }

    let canvasType: HSBCanvasType
    let verticalSwatches: Int
    let horizontalSwatches: Int
    @Binding var hue: Double
    @Binding var saturation: Double
    @Binding var brightness: Double
    @Binding var alpha: Double

    func getColourParameters(yIndex: Int, xIndex: Int) -> (Double, Double, Double, Double) {
        let horizontalParameter = canvasType.firstSliderType
        let verticalParameter = canvasType.secondSliderType

        var hue = Double(1)
        var saturation = Double(1)
        var brightness = Double(1)
        var opacity = Double(1)

        let xDecimal = Double(xIndex) / Double(horizontalSwatches - 1)
        let yDecimal = Double(yIndex) / Double(verticalSwatches - 1)

        switch horizontalParameter {
        case .hue:
            hue = xDecimal
        case .saturation:
            saturation = xDecimal
        case .brightness:
            brightness = xDecimal
        case .alpha:
            opacity = xDecimal
        }

        switch verticalParameter {
        case .hue:
            hue = yDecimal
        case .saturation:
            saturation = yDecimal
        case .brightness:
            brightness = yDecimal
        case .alpha:
            opacity = yDecimal
        }

        return (hue, saturation, brightness, opacity)
    }

    func getColourFromIndices(yIndex: Int, xIndex: Int) -> Color {
        let colourParameters = getColourParameters(yIndex: yIndex, xIndex: xIndex)
        let hue = colourParameters.0
        let saturation = colourParameters.1
        let brightness = colourParameters.2
        let alpha = colourParameters.3

        return Color(hue: hue, saturation: saturation, brightness: brightness, opacity: alpha)
    }

    public var body: some View {
        VStack {
            ForEach(0 ..< verticalSwatches, id: \.self) {
                yIndex in
                HStack {
                    ForEach(0 ..< self.horizontalSwatches, id: \.self) {
                        xIndex in
                        Button(action: {
                            let colourParameters = self.getColourParameters(yIndex: yIndex, xIndex: xIndex)

                            self.hue = colourParameters.0
                            self.saturation = colourParameters.1
                            self.brightness = colourParameters.2
                            self.alpha = colourParameters.3
            }) {
                            ZStack {
                                TransparencyCheckerboardView(tileSize: 5)
                                self.getColourFromIndices(yIndex: yIndex, xIndex: xIndex)
                            }
                        }
                    }
                }
            }
        }
    }
}

public struct PreviewColorView: View {
    public init(colour: Color, square: Bool) {
        self.colour = colour
        self.square = square
    }

    let colour: Color
    let square: Bool
    public var body: some View {
        ZStack {
            if square {
                Group {
                    TransparencyCheckerboardView()
                    Rectangle()
                        .foregroundColor(colour)
                }
                .aspectRatio(1, contentMode: .fit)
            } else {
                Group {
                    TransparencyCheckerboardView()
                    Rectangle()
                        .foregroundColor(colour)
                }
            }
        }
    }
}

public struct ColourSlider: View {
    public init(sliderType: HSBSliderType, hue: Binding<Double>, saturation: Binding<Double>, brightness: Binding<Double>, alpha: Binding<Double>) {
        self.sliderType = sliderType
        _hue = hue
        _saturation = saturation
        _brightness = brightness
        _alpha = alpha
    }

    @Binding var hue: Double
    @Binding var saturation: Double
    @Binding var brightness: Double
    @Binding var alpha: Double
  
    let sliderType: HSBSliderType
    var bindingValue: Binding<Double> {
        switch sliderType {
        case .hue:
            return $hue
        case .saturation:
            return $saturation
        case .brightness:
            return $brightness
        case .alpha:
            return $alpha
        }
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                TransparencyCheckerboardView()
                    .frame(height: 50, alignment: .center)
                    .cornerRadius(geometry.size.height / 4)
                self.sliderType.gradient(hue: self.hue, saturation: self.saturation, brightness: self.brightness)
                    .frame(height: 50, alignment: .center)
                    .cornerRadius(geometry.size.height / 4)
                Group {
                    Capsule()
                        .stroke(lineWidth: 5)
                        .frame(width: 10, height: 70)
                        .horizontalDrag(value: self.bindingValue, width: geometry.size.width)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(height: 70)
        .padding()
    }
}

struct SharedComponents_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}