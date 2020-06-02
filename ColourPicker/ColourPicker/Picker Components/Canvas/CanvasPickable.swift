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
            DoubleGradientView(horizontal: self.parameters.0, vertical: self.parameters.1)
            CanvasThumbView(size: geometry.size, xValue: self.bindingValues().0, yValue: self.bindingValues().1)
          }
      }
      .background(TransparencyCheckerboardView(tileSize: 20))
      .aspectRatio(1, contentMode: .fit)
  }
}

struct CanvasPickable_Previews: PreviewProvider {
  static var previews: some View {
    /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
  }
}
