//
//  DoubleGradientView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 02/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI


struct DoubleGradientView: View {
  let horizontal: Parameter
  let vertical: Parameter
  var body: some View {
    ZStack {
      if horizontal != .alpha && vertical != .alpha {
        Color.black
      }
      //Horizontal gradient
      // - Start at vertical colour
      // - End at blend of both
      LinearGradient(gradient: Gradient(colors: [.blue, Color(red: 1, green: 0, blue: 1, opacity: 0.5)]), startPoint: .leading, endPoint: .trailing)
        .mask (//Mask top to bottom to make vertical gradient visible
          LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .top, endPoint: .bottom)
      )
      //Horizontal gradient
      // - Start at horizontal colour
      // - End at blend of both
      LinearGradient(gradient: Gradient(colors: [.red, Color(red: 1, green: 0, blue: 1, opacity: 0.5)]), startPoint: .top, endPoint: .bottom)
      .mask (//Mask left tor ight to make horizontal gradient visible
        LinearGradient(gradient: Gradient(colors: [.white, .clear]), startPoint: .trailing, endPoint: .leading)
      )
    }
  }
}

struct DoubleGradientView_Previews: PreviewProvider {
    static var previews: some View {
      DoubleGradientView(horizontal: .hue, vertical: .saturation)
        .aspectRatio(1, contentMode: .fit)
    }
}
