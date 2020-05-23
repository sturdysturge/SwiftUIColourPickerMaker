import SwiftUI

public struct PreviewView: View {
  public init() {}
  @ObservedObject var colourModel = ColourModel.shared
  
  public var body: some View {
    VStack {
      PreviewColorView(colour: colourModel.colour, square: true)
    GridPaletteView(canvasType: .hueAlpha, verticalSwatches: 10, horizontalSwatches: 10, hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha)
      .aspectRatio(1, contentMode: .fit)
    
    }
  }
}

struct PreviewView_Previews: PreviewProvider {
  public static var previews: some View {
    PreviewView()
  }
}