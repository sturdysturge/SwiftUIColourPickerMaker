//
//  DoubleGradientView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 02/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI


struct DoubleGradientView: View {
  let parameters: (Parameter, Parameter)
  var body: some View {
    EmptyView()
  }
}

struct DoubleGradientView_Previews: PreviewProvider {
    static var previews: some View {
      DoubleGradientView(parameters: (.hue, .saturation))
    }
}
