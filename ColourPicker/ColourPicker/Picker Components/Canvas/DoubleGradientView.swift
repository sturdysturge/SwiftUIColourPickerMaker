//
//  DoubleGradientView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 02/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol DoubleGradientDisplayable {
    var horizontal: Parameter { get }
    var vertical: Parameter { get }
    var horizontalGradient: Gradient { get }
    var verticalGradient: Gradient { get }
    var backgroundColour: Color { get }
}

extension DoubleGradientDisplayable where Self: View {
    var body: some View {
        ZStack {
            // Horizontal gradient
            // - Start at vertical colour
            // - End at blend of both
            LinearGradient(gradient: horizontalGradient, startPoint: .leading, endPoint: .trailing)
                .mask( // Mask top to bottom to make vertical gradient visible
                    LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .top, endPoint: .bottom)
                )
            // Vertical gradient
            // - Start at horizontal colour
            // - End at blend of both
            LinearGradient(gradient: verticalGradient, startPoint: .top, endPoint: .bottom)
                .mask( // Mask left tor ight to make horizontal gradient visible
                    LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .leading, endPoint: .trailing)
                )
        }
        .background(self.backgroundColour)
    }
}

struct DoubleGradientView: View, DoubleGradientDisplayable {
    let horizontal: Parameter
    let vertical: Parameter
    let horizontalGradient: Gradient
    let verticalGradient: Gradient
    let backgroundColour: Color
    init(horizontal: Parameter, vertical: Parameter, hue _: Double?) {
        horizontal.checkCompatibility(with: vertical)
        self.horizontal = horizontal
        self.vertical = vertical
        horizontalGradient = horizontal.canvasGradient(axis: .horizontal, otherParameter: vertical)
        verticalGradient = vertical.canvasGradient(axis: .vertical, otherParameter: horizontal)
        backgroundColour = .getBackgroundColour(parameters: (horizontal, vertical))
    }
}

struct DoubleGradientView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            TransparencyCheckerboardView()
                .aspectRatio(1, contentMode: .fit)
            DoubleGradientView(horizontal: .hue, vertical: .alpha, hue: 1)
                .aspectRatio(1, contentMode: .fit)
        }
    }
}
