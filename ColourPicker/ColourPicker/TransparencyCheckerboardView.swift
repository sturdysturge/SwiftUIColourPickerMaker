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
    public init(tileSize: CGFloat = 10, colour1: Color = .white, colour2: Color = .gray) {
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

    func horizontalOffset(verticalPosition: CGFloat) -> CGFloat {
        return Int(verticalPosition) % (Int(tileSize) * 2) == 0 ? tileSize : 0
    }

    public var body: some View {
        ZStack {
            GeometryReader { geometry in
                ForEach(0 ..< Int(geometry.size.height / self.tileSize), id: \.self) {
                    yIndex in
                    ForEach(0 ..< Int(geometry.size.width / self.tileSize), id: \.self) {
                        xIndex in
                        Rectangle()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: self.tileSize, height: self.tileSize)
                            .position(x: self.tileSize * CGFloat(xIndex), y: self.tileSize * CGFloat(yIndex))
                            .foregroundColor(self.squareColour(horizontalIndex: xIndex, verticalIndex: yIndex))
                    }
                }
            }
        }
        .offset(x: self.tileSize / 2, y: self.tileSize / 2)
        .mask(Rectangle())
    }
}

struct TransparencyCheckerboardView_Previews: PreviewProvider {
    static var previews: some View {
        TransparencyCheckerboardView()
    }
}
