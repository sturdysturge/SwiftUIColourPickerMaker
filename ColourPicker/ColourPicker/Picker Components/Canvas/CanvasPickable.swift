//
//  CanvasPickable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 02/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol CanvasPickable {
  var parameters: ( Parameter, Parameter) { get }
  func bindingValues() -> (Binding<Double>, Binding<Double>)
}

extension CanvasPickable where Self: View {
  var body: some View {
      ZStack {
          GeometryReader { geometry in
            DoubleGradientView(parameters: self.parameters)
            CanvasThumbView(size: geometry.size, xValue: self.bindingValues().0, yValue: self.bindingValues().1)
          }
      }
      .background(TransparencyCheckerboardView(tileSize: 20))
      .aspectRatio(1, contentMode: .fit)
  }
}
