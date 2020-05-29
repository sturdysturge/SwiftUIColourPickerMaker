//
//  ColourPicker.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 28/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct ColourPicker {
  struct RGBA: ColourPickable {
    let controls: [Control]
    let interface: Interface
    let configuration: Configuration
    let parameters: [Parameter]
    let colourSpace = ColourSpace.RGBA
    init(interface: Interface, configuration: Configuration) {
      
      let string = configuration.rawValue
      var parameters = [Parameter]()
      Array(string).forEach { parameters.append(Parameter(colourSpace: .RGBA, character: String($0))) }
      assert(parameters.count == 4, "Not enough parameters")
      
      self.parameters = parameters
      self.interface = interface
      self.configuration = configuration
      self.controls = interface.controls
    }
    enum Interface: CaseIterable {
    case twoCanvases, twoWheels, twoPalettes, oneCanvasTwoSliders, oneWheelTwoSliders, onePaletteTwoSliders, oneCanvasOneWheel, oneCanvasOnePalette, oneWheelOnePalette
      
      var controls: [Control] {
        switch self {
          
        case .twoCanvases:
          return [.canvas, .canvas]
        case .twoWheels:
          return [.wheel, .wheel]
        case .twoPalettes:
          return [.palette, .palette]
        case .oneCanvasTwoSliders:
          return [.canvas, .slider, .slider]
        case .oneWheelTwoSliders:
          return [.wheel, .slider, .slider]
        case .onePaletteTwoSliders:
          return [.palette, .slider, .slider]
        case .oneCanvasOneWheel:
          return [.canvas, .wheel]
        case .oneCanvasOnePalette:
          return [.canvas, .palette]
        case .oneWheelOnePalette:
          return [.wheel, .palette]
        }
      }
  }
    enum Configuration: String, CaseIterable {
      case RGBA, RGAB, RBGA, RBAG, RAGB, RABG, GRBA, GRAB, GBRA, GBAR, GABR, GARB, BRGA, BRAG, BAGR, BARG, BGRA, BGAR, ARGB, ARBG, AGRB, AGBR, ABRG, ABGR
    }
  }

  struct HSBA: ColourPickable {
    let controls: [Control]
    let interface: Interface
    let configuration: Configuration
    let parameters: [Parameter]
    let colourSpace = ColourSpace.HSBA
    init(interface: Interface, configuration: Configuration) {
      
      let string = configuration.rawValue
      var parameters = [Parameter]()
      Array(string).forEach { parameters.append(Parameter(colourSpace: .HSBA, character: String($0))) }
      assert(parameters.count == 4 || parameters.count == 5, "Not enough parameters")
      
      self.parameters = parameters
      self.interface = interface
      self.configuration = configuration
      self.controls = interface.controls
    }
    
    enum Interface: CaseIterable {
      case twoCanvases, twoWheels, twoPalettes, oneCanvasTwoSliders, oneWheelTwoSliders, onePaletteTwoSliders, oneCanvasOneWheel, oneCanvasOnePalette, oneWheelOnePalette
      
      var numberOfControls: Int {
        switch self {
        case .twoCanvases, .twoWheels, .twoPalettes, .oneCanvasOneWheel, .oneCanvasOnePalette, .oneWheelOnePalette:
          return 2
        case .oneCanvasTwoSliders, .oneWheelTwoSliders, .onePaletteTwoSliders:
          return 3
        }
      }
      
      var controls: [Control] {
        switch self {
          
        case .twoCanvases:
          return [.canvas, .canvas]
        case .twoWheels:
          return [.wheel, .wheel]
        case .twoPalettes:
          return [.palette, .palette]
        case .oneCanvasTwoSliders:
          return [.canvas, .slider, .slider]
        case .oneWheelTwoSliders:
          return [.wheel, .slider, .slider]
        case .onePaletteTwoSliders:
          return [.palette, .slider, .slider]
        case .oneCanvasOneWheel:
          return [.canvas, .wheel]
        case .oneCanvasOnePalette:
          return [.canvas, .palette]
        case .oneWheelOnePalette:
          return [.wheel, .palette]
        }
      }
    }
    enum Configuration: String, CaseIterable {
      case SBHA, SBAH, SHBA, SHAB, SAHB, SABH, BSHS, BSSH, BHAS, BHSA, BAHS, BASH, HSBA, HSAB, HBSA, HBAS, HASB, HABS, AHSB, AHBS, ASHB, ASBH, ABSH, ABHS
    }
  }

  struct CMYKA: ColourPickable {
    var controls: [Control]
    
    let interface: Interface
    let configuration: Configuration
    let parameters: [Parameter]
    let colourSpace = ColourSpace.CMYKA
    init(interface: Interface, configuration: Configuration) {
      
      let string = configuration.rawValue
      var parameters = [Parameter]()
      Array(string).forEach { parameters.append(Parameter(colourSpace: .CMYKA, character: String($0))) }
      assert(parameters.count == 5, "Not enough parameters")
      
      self.parameters = parameters
      self.interface = interface
      self.configuration = configuration
      self.controls = interface.controls
    }
    enum Interface {
    case fiveSliders, twoCanvasesOneSlider, twoWheelsOneSlider, twoPalettesOneSlider, oneCanvasOneWheelOneSlider, oneCanvasOnePaletteOneSlider, oneWheelOnePaletteOneSlider, oneCanvasThreeSliders, oneWheelThreeSliders, onePaletteThreeSliders
    
    var numberOfControls: Int {
      switch self {
        case .twoCanvasesOneSlider, .twoWheelsOneSlider, .twoPalettesOneSlider, .oneCanvasOneWheelOneSlider, .oneCanvasOnePaletteOneSlider, .oneWheelOnePaletteOneSlider: return 3
        case .oneCanvasThreeSliders, .oneWheelThreeSliders, .onePaletteThreeSliders:
          return 4
        case .fiveSliders:
          return 5
      }
    }
      
      var controls: [Control] {
        switch self {
          
        case .fiveSliders:
          return [.slider, .slider, .slider, .slider, .slider]
        case .twoCanvasesOneSlider:
          return [.canvas, .canvas, .slider]
        case .twoWheelsOneSlider:
          return [.wheel, .wheel, .slider]
        case .twoPalettesOneSlider:
          return [.palette, .palette, .slider]
        case .oneCanvasOneWheelOneSlider:
          return [.canvas, .wheel, .slider]
        case .oneCanvasOnePaletteOneSlider:
          return [.canvas, .palette, .slider]
        case .oneWheelOnePaletteOneSlider:
          return [.wheel, .palette, .slider]
        case .oneCanvasThreeSliders:
          return [.canvas, .slider, .slider, .slider]
        case .oneWheelThreeSliders:
          return [.wheel, .slider, .slider, .slider]
        case .onePaletteThreeSliders:
          return [.palette, .slider, .slider, .slider]
        }
      }
    }
    enum Configuration: String, CaseIterable {
      
      case CMYKA, CMYAK, CMKYA, CMKAY, CMAYK, CMAKY, CYMKA, CYMAK, CYKMA, CYKAM, CYAMK, CYAKM, CKMYA, CKMAY, CKYMA, CKYAM, CKAMY, CKAYM, CAMYK, CAMKY, CAYMK, CAYKM, CAKMY, CAKYM, MCYKA, MCYAK, MCKYA, MCKAY, MCAYK, MCAKY, MYCKA, MYCAK, MYKCA, MYKAC, MYACK, MYAKC, MKCYA, MKCAY, MKYCA, MKYAC, MKACY, MKAYC, MACYK, MACKY, MAYCK, MAYKC, MAKCY, MAKYC, YCMKA, YCMAK, YCKMA, YCKAM, YCAMK, YCAKM, YMCKA, YMCAK, YMKCA, YMKAC, YMACK, YMAKC, YKCMA, YKCAM, YKMCA, YKMAC, YKACM, YKAMC, YACMK, YACKM, YAMCK, YAMKC, YAKCM, YAKMC, KCMYA, KCMAY, KCYMA, KCYAM, KCAMY, KCAYM, KMCYA, KMCAY, KMYCA, KMYAC, KMACY, KMAYC, KYCMA, KYCAM, KYMCA, KYMAC, KYACM, KYAMC, KACMY, KACYM, KAMCY, KAMYC, KAYCM, KAYMC, ACMYK, ACMKY, ACYMK, ACYKM, ACKMY, ACKYM, AMCYK, AMCKY, AMYCK, AMYKC, AMKCY, AMKYC, AYCMK, AYCKM, AYMCK, AYMKC, AYKCM, AYKMC, AKCMY, AKCYM, AKMCY, AKMYC, AKYCM, AKYMC
    }
  }

  struct Greyscale {
    enum Interface {
      case twoSliders, oneCanvas, oneWheel, onePalette
      
      var numberOfControls: Int {
        switch self {
          
        case .twoSliders:
          return 2
        case .oneCanvas, .oneWheel, .onePalette:
          return 1
        }
      }
    }
    enum Configuration: String, CaseIterable {
      case WA, AW
      
      var parameters: [Parameter] {
        switch self {
        case .WA: return [.whiteness, .alpha]
        case .AW: return [.alpha, .whiteness]
        }
      }
    }
  }
}
enum Control {
case slider, canvas, palette, wheel
}
struct Controlfd: Hashable {
  let type: ControlType
  enum ControlType {
  case slider, canvas, palette, wheel
  }
//  static var slider: Control {return Control(type: .slider)}
//  static var canvas: Control {return Control(type: .canvas)}
//  static var palette: Control {return Control(type: .palette)}
//  static var wheel: Control {return Control(type: .wheel)}
}

protocol ColourPickable {
  var colourSpace: ColourSpace { get }
  var parameters: [Parameter] { get }
  var controls: [Control] { get }
}

struct ColourPickerView : View {
  let data: ColourPickable
  
  var body: some View {
    VStack {
      ForEach(data.controls, id: \.self) { control in
        ControlView(control: control)
    }
    }
  }
}

struct ControlView: View {
  let control: Control
  var body: some View {
    Group {
      if control == .slider {
        Text("Slider")
      }
      else if control == .canvas {
        Text("Canvas")
      }
      else if control == .wheel {
        Text("Wheel")
      }
      else if control == Control.palette {
        Text("Palette")
      }
    }
  }
}
