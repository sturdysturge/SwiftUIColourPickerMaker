//
//  PreviewColourView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI
struct PreviewColourView {
  let colour: Color
  let square: Bool
}

extension PreviewColourView: View {
  
  var body: some View {
    ZStack {
      if square {
        Group {
          GeometryReader { geometry in
          TransparencyCheckerboardView(tileSize: 20)
              Rectangle()
                .foregroundColor(self.colour)
                .frame(width: geometry.size.width - 19, height: geometry.size.height - 19)
            }
          
        }
        .aspectRatio(1, contentMode: .fit)
      } else {
        //Not square
        Group {
          GeometryReader { geometry in
          TransparencyCheckerboardView(tileSize: 20)
          Rectangle()
            .foregroundColor(self.colour)
            .frame(width: geometry.size.width - 19, height: geometry.size.height - 19)
            }
        }
      }
    }
  }
}
