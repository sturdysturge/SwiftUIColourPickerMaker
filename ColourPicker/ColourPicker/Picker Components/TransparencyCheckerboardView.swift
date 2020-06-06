//
//  TransparencyCheckerboardView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 30/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

/// A background that can only be seen when Color opacity is less than 1.0
struct TransparencyCheckerboardView: TransparencyCheckerboardDisplayable {
    let tileSize: CGFloat
    let colour1: Color
    let colour2: Color
    init(tileSize: CGFloat = 20, colour1: Color = .white, colour2: Color = .gray) {
        self.tileSize = tileSize
        self.colour1 = colour1
        self.colour2 = colour2
    }
}

protocol TransparencyCheckerboardDisplayable: View {
    /// The size for each white or grey tile
    var tileSize: CGFloat { get }
    /// The first colour to alternate between
    var colour1: Color { get }
    /// The second colour to alternate between
    var colour2: Color { get }
    /// Calculates what colour each tile should be based on its position
    /// - Parameters:
    ///   - column: How far along the tile is horizontally
    ///   - row: How far along the tile is vertically
    /// - Returns: The colour the tile should be
    func squareColour(column: Int, row: Int) -> Color
}

extension TransparencyCheckerboardDisplayable {
    var body: some View {
        ZStack {
            GeometryReader { geometry in
              ForEach(0 ..< Int((geometry.size.height / self.tileSize) + 0.5), id: \.self) {
                    yIndex in
                    ForEach(0 ..< Int((geometry.size.width / self.tileSize) + 0.5), id: \.self) {
                        xIndex in
                        Rectangle()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: self.tileSize, height: self.tileSize)
                            .position(x: self.tileSize * CGFloat(xIndex), y: self.tileSize * CGFloat(yIndex))
                            .foregroundColor(self.squareColour(column: xIndex, row: yIndex))
                    }
                }
            }
        }
        .offset(x: self.tileSize / 2, y: self.tileSize / 2)
        .mask(Rectangle())
    }

    func squareColour(column: Int, row: Int) -> Color {
        if row % 2 == 0 {
            return column % 2 == 0 ? colour2 : colour1
        } else {
            return column % 2 != 0 ? colour2 : colour1
        }
    }
}

struct TransparencyCheckerboardView_Previews: PreviewProvider {
    static var previews: some View {
        TransparencyCheckerboardView()
    }
}
