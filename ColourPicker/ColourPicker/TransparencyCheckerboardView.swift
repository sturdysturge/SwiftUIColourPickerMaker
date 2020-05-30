//
//  TransparencyCheckerboardView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 30/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

/// A background that can only be seen when Color opacity is less than 1.0
public struct TransparencyCheckerboardView: View {
    /// The size for each white or grey tile
    let tileSize: CGFloat
    /// The first colour to alternate between
    let colour1: Color
    /// The second colour to alternate between
    let colour2: Color

    /// A constructor that allows custom checkerboards
    /// - Parameters:
    ///   - tileSize: A width/height for each tile
    ///   - colour1: The first colour to alternate between
    ///   - colour2: The second colour to alternate between
    public init(tileSize: CGFloat = 20, colour1: Color = .white, colour2: Color = .gray) {
        self.tileSize = tileSize
        self.colour1 = colour1
        self.colour2 = colour2
    }

    /// Calculates what colour each tile should be based on its position
    /// - Parameters:
    ///   - horizontalIndex: How far along the tile is horizontally
    ///   - verticalIndex: How far along the tile is vertically
    /// - Returns: The colour the tile should be
    func squareColour(horizontalIndex: Int, verticalIndex: Int) -> Color {
        if verticalIndex % 2 == 0 {
            return horizontalIndex % 2 == 0 ? .gray : .white
        } else {
            return horizontalIndex % 2 != 0 ? .gray : .white
        }
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(0 ... Int(geometry.size.height / self.tileSize), id: \.self) { verticalIndex in
                    HStack(spacing: 0) {
                        ForEach(0 ... Int(geometry.size.width / self.tileSize), id: \.self) { horizontalIndex in
                            Rectangle()
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(self.squareColour(horizontalIndex: horizontalIndex, verticalIndex: verticalIndex))
                        }
                    }
                }
            }
        }
    }
}

struct TransparencyCheckerboardView_Previews: PreviewProvider {
    static var previews: some View {
        TransparencyCheckerboardView()
    }
}
