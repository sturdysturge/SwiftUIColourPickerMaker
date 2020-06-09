//  PreviewColourView.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

public struct PreviewColourView {
    let colour: Color
    let square: Bool
}

extension PreviewColourView: View {
  public var body: some View {
        ZStack {
            if square {
                Group {
                    TransparencyCheckerboardView()
                    Rectangle()
                        .foregroundColor(colour)
                }
                .aspectRatio(1, contentMode: .fit)
            } else { // Not square
                Group {
                    TransparencyCheckerboardView()
                    Rectangle()
                        .foregroundColor(colour)
                }
            }
        }
    }
}
