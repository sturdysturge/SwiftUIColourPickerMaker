import SwiftUI

public struct PreviewView: View {
  public init() {}
  @ObservedObject var colourModel = ColourModel.shared
  
  public var body: some View {
    VStack {
      PreviewColorView(colour: colourModel.colour, square: true)
    ColourWheelView(rotation: $colourModel.hue, distanceFromCentre: $colourModel.saturation)
    }
  }
}

struct PreviewView_Previews: PreviewProvider {
  public static var previews: some View {
    PreviewView()
  }
}
