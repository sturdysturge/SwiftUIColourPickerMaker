//
//  ColourPicker.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 28/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct ColourPicker {
  struct RGBA {
    let interface: Interface
    let configuration: Configuration
    let parameters: [Parameter]
    init(interface: Interface, configuration: Configuration) {
      
      let string = configuration.rawValue
      var parameters = [Parameter]()
      Array(string).forEach { parameters.append(Parameter(colourSpace: .RGBA, character: String($0))) }
      assert(parameters.count == 4, "Not enough parameters")
      
      self.parameters = parameters
      self.interface = interface
      self.configuration = configuration
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
  }
    enum Configuration: String, CaseIterable {
      case RGBA, RGAB, RBGA, RBAG, RAGB, RABG, GRBA, GRAB, GBRA, GBAR, GABR, GARB, BRGA, BRAG, BAGR, BARG, BGRA, BGAR, ARGB, ARBG, AGRB, AGBR, ABRG, ABGR
    }
  }

  struct HSBA {
    let interface: Interface
    let configuration: Configuration
    let parameters: [Parameter]
    init(interface: Interface, configuration: Configuration) {
      
      let string = configuration.rawValue
      var parameters = [Parameter]()
      Array(string).forEach { parameters.append(Parameter(colourSpace: .HSBA, character: String($0))) }
      assert(parameters.count == 4 || parameters.count == 5, "Not enough parameters")
      
      self.parameters = parameters
      self.interface = interface
      self.configuration = configuration
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
    }
    enum Configuration: String, CaseIterable {
      case SBHA, SBAH, SHBA, SHAB, SAHB, SABH, BSHS, BSSH, BHAS, BHSA, BAHS, BASH, HSBA, HSAB, HBSA, HBAS, HASB, HABS, AHSB, AHBS, ASHB, ASBH, ABSH, ABHS
    }
  }

  struct CMYKA {
    let interface: Interface
    let configuration: Configuration
    let parameters: [Parameter]
    
    init(interface: Interface, configuration: Configuration) {
      
      let string = configuration.rawValue
      var parameters = [Parameter]()
      Array(string).forEach { parameters.append(Parameter(colourSpace: .CMYKA, character: String($0))) }
      assert(parameters.count == 5, "Not enough parameters")
      
      self.parameters = parameters
      self.interface = interface
      self.configuration = configuration
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

struct ColourPickerView : View {
  let data: ColourPicker
  
  var body: some View {
    EmptyView()
  }
}
