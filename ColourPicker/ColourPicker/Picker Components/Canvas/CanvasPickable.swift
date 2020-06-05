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
}

extension CanvasPickable {
    var body: some View {
        ZStack {
            Color(hue: self.data.getHue() ?? 0, saturation: 1, brightness: 1, opacity: self.data.getHue() ?? 0)
            GeometryReader { geometry in
                DoubleGradientView(horizontal: self.data.parameters.0, vertical: self.data.parameters.1, hue: self.data.getHue())
                CanvasThumbView(size: geometry.size, xValue: self.data.bindingValues().0, yValue: self.data.bindingValues().1)
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
