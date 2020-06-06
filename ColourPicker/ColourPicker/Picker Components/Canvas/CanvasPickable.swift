//
//  CanvasPickable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 02/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol CanvasPickable: View {
    associatedtype DataType where DataType: DataStorable
    var data: DataType { get }
    var thumbOffset: CGPoint { get }
    var _$thumbOffset: Binding<CGPoint> { get }
  
}

extension CanvasPickable {
    var body: some View {
        ZStack {
          data.getBackground()
            GeometryReader { geometry in
                DoubleGradientView(horizontal: self.data.parameters.0, vertical: self.data.parameters.1)
                    .bidirectionalDrag(offset: self._$thumbOffset, xValue: self.data.bindingValues().x, yValue: self.data.bindingValues().y, size: geometry.size)
                CircleThumbView(size: 25)
                    .offset(x: self.thumbOffset.x, y: self.thumbOffset.y)
            }
        }
        .background(TransparencyCheckerboardView())
        .aspectRatio(1, contentMode: .fit)
    }
}

struct CanvasPickable_Previews: PreviewProvider {
    static var previews: some View {
      ContentView_Previews.previews
    }
}
