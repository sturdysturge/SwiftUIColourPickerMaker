//
//  CircleGradientView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct CircleGradientView: CircleGradientDisplayable {
    let angularGradient: Gradient
    let radialGradient: Gradient
    let radius: CGFloat
}

protocol CircleGradientDisplayable: View {
    var angularGradient: Gradient { get }
    var radialGradient: Gradient { get }
    var radius: CGFloat { get }
}

extension CircleGradientDisplayable {
    var body: some View {
        ZStack {
            AngularGradient(gradient: self.angularGradient, center: .center, startAngle: .degrees(-89), endAngle: .degrees(270))
                .clipShape(Circle())
            RadialGradient(gradient: self.radialGradient, center: .center, startRadius: 10, endRadius: radius)
                .clipShape(Circle())
        }
    }
}

struct CircleGradientView_Previews: PreviewProvider {
    static let angularGradient = Gradient.hue
    static let radialGradient = Gradient(colors: [.white, Color(white: 1, opacity: 0.2), .clear])
    static var previews: some View {
        CircleGradientView(angularGradient: self.angularGradient, radialGradient: self.radialGradient, radius: 150)
    }
}
