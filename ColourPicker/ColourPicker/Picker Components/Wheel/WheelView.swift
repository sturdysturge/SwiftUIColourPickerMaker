//
//  WheelView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

public struct WheelView: View {
    public init(rotation: Binding<Double>, distanceFromCentre: Binding<Double>, angularGradient: Gradient = Gradient(colors: []), radialGradient: Gradient = Gradient(colors: [])) {
        _rotation = rotation
        _distanceFromCentre = distanceFromCentre
        self.angularGradient = angularGradient
        self.radialGradient = radialGradient
    }

    let angularGradient: Gradient
    let radialGradient: Gradient
    @Binding var rotation: Double
    @Binding var distanceFromCentre: Double
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                AngularGradient(gradient: self.angularGradient, center: .center)
                RadialGradient(gradient: self.radialGradient, center: .center, startRadius: 0, endRadius: geometry.size.width / 2)
                Group {
                    Circle()
                        .stroke(lineWidth: 5)
                        .frame(width: 25, height: 25)
                        .radialDrag(rotation: self.$rotation, distanceFromCentre: self.$distanceFromCentre, size: geometry.size)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
      WheelView(rotation: .constant(0.5), distanceFromCentre: .constant(0.5))
    }
}
