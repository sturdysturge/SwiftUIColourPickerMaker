import SwiftUI

public struct PreviewView: View {
    public init() {}
    @ObservedObject var colourModel = ColourModel.shared

    public var body: some View {
        VStack {
            PreviewColorView(colour: colourModel.colour, square: true)
            ColourSlider(sliderType: .hue, hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha)
            ColourSlider(sliderType: .saturation, hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha)
            ColourSlider(sliderType: .brightness, hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha)
            ColourSlider(sliderType: .alpha, hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha)
        }
    }
}

struct PreviewView_Previews: PreviewProvider {
    public static var previews: some View {
        PreviewView()
    }
}
