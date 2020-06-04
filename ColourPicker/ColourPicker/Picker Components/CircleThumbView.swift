//
//  CircleThumbView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct CircleThumbView: View {
  var body: some View {
    ZStack {
      Circle()
        .stroke(lineWidth: 10)
        .foregroundColor(.white)
      Circle()
        .stroke(lineWidth: 5)
        .foregroundColor(.black)
    }
  }
}

struct CircleThumbView_Previews: PreviewProvider {
    static var previews: some View {
        CircleThumbView()
    }
}
