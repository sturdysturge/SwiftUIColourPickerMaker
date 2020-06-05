//
//  CanvasPickable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 02/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol CanvasPickable: View {
    associatedtype ValueType
    var data: CanvasData<ValueType> { get }
  var thumbOffset: CGPoint { get }
  var _$thumbOffset: Binding<CGPoint> { get }
}

extension CanvasPickable {
    var body: some View {
        ZStack {
            Color(hue: self.data.getHue() ?? 0, saturation: 1, brightness: 1, opacity: self.data.getHue() ?? 0)
            GeometryReader { geometry in
                DoubleGradientView(horizontal: self.data.parameters.0, vertical: self.data.parameters.1, hue: self.data.getHue())
                  .bidirectionalDrag(offset: self._$thumbOffset, xValue: self.data.bindingValues.x, yValue: self.data.bindingValues.y, size: geometry.size)
              CircleThumbView(size: 25)
                  .offset(x: self.thumbOffset.x, y: self.thumbOffset.y)
            }
        }
        .background(TransparencyCheckerboardView(tileSize: 20))
        .aspectRatio(1, contentMode: .fit)
    }
}

struct CanvasPickable_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
