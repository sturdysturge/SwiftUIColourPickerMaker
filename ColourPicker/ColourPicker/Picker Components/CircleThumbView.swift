//
//  CircleThumbView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct CircleThumbView {
  let size: CGFloat
}

extension CircleThumbView: View {
    var body: some View {
        ZStack {
          Group {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundColor(.white)
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(.black)
          }
          .frame(width: self.size, height: self.size)
        }
    }
}

struct CircleThumbView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
