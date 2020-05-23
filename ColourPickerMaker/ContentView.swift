import SwiftUI



class ColourModel: ObservableObject {
  @Published var colour = Color.white
  @Published var hue = Double(0.5) { didSet { setColour() } }
  @Published var saturation = Double(0) { didSet { setColour() } }
  @Published var brightness = Double(0) { didSet { setColour() } }
  @Published var alpha = Double(1) { didSet {
    setColour() } }
  static let shared = ColourModel()
  
  func setColour() {
    self.colour = Color(hue: hue, saturation: saturation, brightness: brightness, opacity: alpha)
  }
}

struct EveryHSBColourCanvasView: View {
  @EnvironmentObject var colourModel: ColourModel
  var body: some View {
    VStack {
      PreviewColorView(colour: colourModel.colour, square: false)
        .frame(maxWidth: .infinity, maxHeight: 100)
    ScrollView {
      VStack {
      ForEach(HSBCanvasType.allCases, id: \.self) {
        type in
        Group {
        Text(type.rawValue)
        ColourCanvasView(hue: self.$colourModel.hue, saturation: self.$colourModel.saturation, brightness: self.$colourModel.brightness, alpha: self.$colourModel.alpha, canvasType: type)
          .environmentObject(self.colourModel)
        }
        }
      }
      }
      
    }
  }
}

struct ContentView: View {
  @ObservedObject var colourModel = ColourModel.shared
  var body: some View {
    VStack {
      PreviewColorView(colour: colourModel.colour, square: true)
    GridPaletteView(canvasType: .hueAlpha, verticalSwatches: 10, horizontalSwatches: 10, hue: $colourModel.hue, saturation: $colourModel.saturation, brightness: $colourModel.brightness, alpha: $colourModel.alpha)
      .aspectRatio(1, contentMode: .fit)
    
    }
  }
}

struct ColourWheelView: View {
  @State var xValue = Double()
  @State var yValue = Double()
  var body: some View {
    GeometryReader { geometry in
    ZStack {
    AngularGradient(gradient: Gradient(colors: GradientType.hue.colours), center: .center)
      RadialGradient(gradient: Gradient(colors: [Color(white: 1, opacity: 1), Color(white: 1, opacity: 0.9),  Color(white: 1, opacity: 0.8), Color(white: 1, opacity: 0.7),  Color(white: 1, opacity: 0.6), Color(white: 1, opacity: 0.5),  Color(white: 1, opacity: 0.4), Color(white: 1, opacity: 0.3),  Color(white: 1, opacity: 0.2), Color(white: 1, opacity: 0.1),  Color(white: 1, opacity: 0)]), center: .center, startRadius: 0, endRadius: geometry.size.width / 2)
      Group {
      Circle()
      .stroke(lineWidth: 5)
      .frame(width: 25, height: 25)
        .radialDrag(xValue: self.$xValue, yValue: self.$yValue, size: geometry.size)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      }
    }
  }
}

struct GridBackgroundView: View {
  let squareSize: CGFloat
  
  func squareColour(horizontalIndex: Int, verticalIndex: Int) -> Color {
    if verticalIndex % 2 == 0 {
      return horizontalIndex % 2 == 0 ? .gray : .white
    }
    else {
      return horizontalIndex % 2 != 0 ? .gray : .white
    }
    
  }
  
  var body: some View {
    GeometryReader { geometry in
    VStack(spacing: 0) {
      ForEach(0...Int(geometry.size.height / self.squareSize), id: \.self) { verticalIndex in
        HStack(spacing: 0) {
          ForEach(0...Int(geometry.size.width / self.squareSize), id: \.self) { horizontalIndex in
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

struct GridPaletteView: View {
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
    let colourParameters = self.getColourParameters(yIndex: yIndex, xIndex: xIndex)
    let hue = colourParameters.0
    let saturation = colourParameters.1
    let brightness = colourParameters.2
    let alpha = colourParameters.3
    
    return Color(hue: hue, saturation: saturation, brightness: brightness, opacity: alpha)
  }
  
  var body: some View {
    VStack {
      ForEach(0..<verticalSwatches, id: \.self) {
        yIndex in
        HStack {
          ForEach(0..<self.horizontalSwatches, id: \.self) {
            xIndex in
            Button(action: {
              let colourParameters = self.getColourParameters(yIndex: yIndex, xIndex: xIndex)
              
              self.hue = colourParameters.0
              self.saturation = colourParameters.1
              self.brightness = colourParameters.2
              self.alpha = colourParameters.3
            }) {
              ZStack {
                GridBackgroundView(squareSize: 5)
              self.getColourFromIndices(yIndex: yIndex, xIndex: xIndex)
              }
            }
          }
        }
      }
    }
  }
}


struct PreviewColorView: View {
  let colour: Color
  let square: Bool
  var body: some View {
    ZStack {
      
      if square {
        Group {
        GridBackgroundView(squareSize: 20)
      Rectangle()
        .foregroundColor(colour)
        }
        .aspectRatio(1, contentMode: .fit)
      }
      else {
        Group {
          GridBackgroundView(squareSize: 20)
        Rectangle()
          .foregroundColor(colour)
          }
      }
    }
  }
}

struct ColourSlider: View {
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
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        GridBackgroundView(squareSize: 20)
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

struct ColourCanvasView: View {
  @Binding var hue: Double
  @Binding var saturation: Double
  @Binding var brightness: Double
  @Binding var alpha: Double
  let canvasType: HSBCanvasType
  
  func bindingValues() -> (Binding<Double>, Binding<Double>) {
    switch canvasType {
      
    case .saturationBrightness:
      return ($saturation, $brightness)
    case .saturationHue:
      return ($saturation, $hue)
    case .saturationAlpha:
      return ($saturation, $alpha)
    case .brightnessSaturation:
      return ($brightness, $saturation)
    case .brightnessHue:
      return ($brightness, $hue)
    case .brightnessAlpha:
      return ($brightness, $alpha)
    case .hueSaturation:
      return ($hue, $saturation)
    case .hueBrightness:
      return ($hue, $brightness)
    case .hueAlpha:
      return ($hue, $alpha)
    case .alphaHue:
      return ($alpha, $hue)
    case .alphaSaturation:
      return ($alpha, $saturation)
    case .alphaBrightness:
      return ($alpha, $brightness)
    }
  }
  
  var body: some View {
    ZStack {
      GeometryReader { geometry in
        self.canvasType.gradients(hue: self.hue, saturation: self.saturation, brightness: self.brightness)
        Group {
          Circle()
            .stroke(lineWidth: 5)
            .frame(width: 25, height: 25)
            .bidirectionalDrag(xValue: self.bindingValues().0, yValue: self.bindingValues().1, size: geometry.size)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      }
    }
    .background(GridBackgroundView(squareSize: 20))
    .aspectRatio(1, contentMode: .fit)
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
