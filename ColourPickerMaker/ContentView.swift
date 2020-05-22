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

struct HSBColourCanvasPreviews: View {
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
        ColourCanvas(hue: self.$colourModel.hue, saturation: self.$colourModel.saturation, brightness: self.$colourModel.brightness, alpha: self.$colourModel.alpha, canvasType: type)
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
    HSBColourCanvasPreviews()
    .environmentObject(colourModel)
  }
}

struct GridBackgroundView: View {
  func squareColour(horizontalIndex: Int, verticalIndex: Int) -> Color {
    if verticalIndex % 2 == 0 {
      return horizontalIndex % 2 == 0 ? .gray : .white
    }
    else {
      return horizontalIndex % 2 != 0 ? .gray : .white
    }
    
  }
  
  var body: some View {
    VStack(spacing: 0) {
      ForEach(0...10, id: \.self) { verticalIndex in
        HStack(spacing: 0) {
          ForEach(0...10, id: \.self) { horizontalIndex in
            Rectangle()
              .aspectRatio(1, contentMode: .fit)
              .foregroundColor(self.squareColour(horizontalIndex: horizontalIndex, verticalIndex: verticalIndex))
          }
        }
      }
    }
  }
}

enum GradientType {
  case red, green, blue, brightnessOverlay, saturationOverlay, hue, alpha, cyan, yellow, purple
  
  var colours: [Color] {
    switch self {
    case .red:
        return [.clear, .red]
    case .green:
        return [.clear, .green]
    case .blue:
        return [.clear, .blue]
    case .cyan:
      return [.clear, Color(red: 0, green: 1, blue: 1, opacity: 0.7)]
    case .yellow:
      return [.clear, Color(red: 1, green: 1, blue: 0, opacity: 0.7)]
    case .purple:
      return [.clear, Color(red: 1, green: 0, blue: 1, opacity: 0.5)]
    case .brightnessOverlay:
      return [.black, Color(.sRGBLinear, white: 0, opacity: 0.7), Color(.sRGBLinear, white: 0, opacity: 0.5), Color(.sRGBLinear, white: 0, opacity: 0.3)]
    case .saturationOverlay:
      return [.white, Color(.sRGBLinear, white: 1, opacity: 0.9), Color(.sRGBLinear, white: 1, opacity: 0.5), Color(.sRGBLinear, white: 1, opacity: 0.3)]
    case .hue:
        return [.red, .yellow, .green, .blue, .indigo, .violet, .red]
    case .alpha:
        return [Color(.sRGBLinear, white: 1, opacity: 0.5), Color(.sRGBLinear, white: 1, opacity: 0.9), .white]
    }
  }
  
  static func brightness(hue: Double, saturation: Double, startPoint: UnitPoint) -> LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color(hue: hue, saturation: 1, brightness: 0), Color(hue: hue, saturation: 1, brightness: 1)]), startPoint: startPoint, endPoint: startPoint.opposite)
  }
  
  static func saturation(hue: Double, brightness: Double, startPoint: UnitPoint) -> LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [.white, Color(hue: hue, saturation: 1, brightness: 1)]), startPoint: startPoint, endPoint: startPoint.opposite)
  }
  var gradient: Gradient { Gradient(colors: colours) }
    
  var horizontal: LinearGradient { LinearGradient(gradient: self.gradient, startPoint: .leading, endPoint: .trailing) }
  
  var vertical: LinearGradient { LinearGradient(gradient: self.gradient, startPoint: .top, endPoint: .bottom) }
  
  var diagonal: LinearGradient { LinearGradient(gradient: self.gradient, startPoint: .topLeading, endPoint: .bottomTrailing) }
}

struct PreviewColorView: View {
  let colour: Color
  let square: Bool
  var body: some View {
    ZStack {
      GridBackgroundView()
      if square {
      Rectangle()
        .foregroundColor(colour)
        .aspectRatio(1, contentMode: .fit)
      }
      else {
        Rectangle()
        .foregroundColor(colour)
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
        GridBackgroundView()
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

struct ColourCanvas: View {
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
    .background(GridBackgroundView())
    .aspectRatio(1, contentMode: .fit)
  }
}

struct HorizontalSlider: ViewModifier {
  @State var offset = CGPoint(x: 0, y: 0)
  @Binding var value: Double
  let width: CGFloat
  
  func body(content: Content) -> some View {
    content
      .gesture(DragGesture(minimumDistance: 0)
        .onChanged { value in
          self.offset.x += value.location.x - value.startLocation.x
          
          if self.offset.x < 0 {
            self.offset.x = 0
            self.value = 0
          }
          else if self.offset.x > self.width - 10 {
            self.offset.x = self.width - 10
            self.value = 1
          }
          else {
            self.value = Double(self.offset.x / (self.width - 10))
          }
      })
      .offset(x: offset.x, y: offset.y)
  }
}

struct BidirectionalSlider: ViewModifier {
  @State var offset = CGPoint(x: 0, y: 0)
  @Binding var xValue: Double
  @Binding var yValue: Double
  let size: CGSize
  func body(content: Content) -> some View {
    content
      .gesture(DragGesture(minimumDistance: 0)
        .onChanged { value in
          self.offset.x += value.location.x - value.startLocation.x
          self.offset.y += value.location.y - value.startLocation.y
          
          if self.offset.x < 0 {
            self.offset.x = 0
            self.xValue = 0
          }
          else if self.offset.x > self.size.width - 25 {
            self.offset.x = self.size.width - 25
            self.xValue = 1
          }
          else {
            self.xValue = Double(self.offset.x / (self.size.width - 25))
          }
          if self.offset.y < 0 {
            self.offset.y = 0
            self.yValue = 0
          }
          else if self.offset.y > self.size.height - 25 {
            self.offset.y = self.size.height - 25
            self.yValue = 1
          }
          else {
            self.yValue =  Double(self.offset.y / (self.size.height - 25))
          }
      })
      .offset(x: offset.x, y: offset.y)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HSBGradientsGridView()
  }
}
