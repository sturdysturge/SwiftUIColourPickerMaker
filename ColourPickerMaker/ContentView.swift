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
    ColourWheelView()
      .aspectRatio(1, contentMode: .fit)
//    HSBColourCanvasPreviews()
//    .environmentObject(colourModel)
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


struct PreviewColorView: View {
  let colour: Color
  let square: Bool
  var body: some View {
    ZStack {
      GridBackgroundView(squareSize: 20)
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

struct RadialSlider: ViewModifier {
  @State var offset = CGPoint(x: 0, y: 0)
  @Binding var xValue: Double
  @Binding var yValue: Double
  let size: CGSize
  
  func   angleBetweenLines(line1Start: CGPoint, line1End: CGPoint, line2Start: CGPoint, line2End: CGPoint) -> CGFloat {
  let angle1 = atan2(line1Start.y-line1End.y, line1Start.x-line1End.x);
    let angle2 = atan2(line2Start.y-line2End.y, line2Start.x-line2End.x);
  var result = (angle2-angle1) * 180 / 3.14
  if (result<0) {
      result += 360
  }
  return result
  }
  
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
          print( self.angleBetweenLines(line1Start: CGPoint(x: self.size.width / 2, y: 0), line1End: CGPoint(x: self.offset.x, y: self.offset.y), line2Start: CGPoint(x: self.size.width / 2, y: 0), line2End: CGPoint(x: self.size.width / 2, y: 10)) - 90)
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
