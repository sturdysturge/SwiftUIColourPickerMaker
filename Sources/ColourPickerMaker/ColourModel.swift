//
//  File.swift
//  
//
//  Created by Rob Sturgeon on 23/05/2020.
//

import SwiftUI

class ColourModel: ObservableObject {
  @Published var colour = Color.white
  @Published var hue = Double(0.5) { didSet { setColour() } }
  @Published var saturation = Double(1) { didSet { setColour() } }
  @Published var brightness = Double(1) { didSet { setColour() } }
  @Published var alpha = Double(1) { didSet {
    setColour() } }
  static let shared = ColourModel()
  
  func setColour() {
    self.colour = Color(hue: hue, saturation: saturation, brightness: brightness, opacity: alpha)
  }
}
