//
//  SliderView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct SliderView: View {
  let parameter: Parameter
  @Binding var value: Double
  let gradient: LinearGradient
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        if self.parameter == .alpha {
        TransparencyCheckerboardView()
          .frame(height: 50, alignment: .center)
          .cornerRadius(geometry.size.height / 4)
        }
        else {
          Color.white
        }
        self.gradient
          .frame(height: 50, alignment: .center)
          .cornerRadius(geometry.size.height / 4)
        Group {
          Capsule()
            .stroke(lineWidth: 5)
            .frame(width: 10, height: 70)
            .horizontalDrag(value: self.$value, width: geometry.size.width)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .frame(height: 70)
    .padding()
  }
}

//struct SliderView_Previews: PreviewProvider {
//  static var previews: some View {
//    SliderView()
//  }
//}
