//
//  PalettePickable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol PalettePickable: View {
    associatedtype ValueType where ValueType: PaletteDataStorable
    var data: ValueType { get }
}

extension PalettePickable {
    var body: some View {
        VStack {
            ForEach(0 ..< data.size.rows, id: \.self) {
                yIndex in
                HStack {
                    ForEach(0 ..< self.data.size.columns, id: \.self) {
                        xIndex in
                        Button(action: {
                            let swatch = self.data.getSwatch(xIndex: xIndex, yIndex: yIndex)
                            self.data.bindingValues.x.wrappedValue = self.data.getSwatchParameter(.horizontal, swatch: swatch)
                            self.data.bindingValues.y.wrappedValue = self.data.getSwatchParameter(.vertical, swatch: swatch)
                        }
                        )
                        {
                            ZStack {
                                TransparencyCheckerboardView()
                                self.data.getSwatchColour(values: self.data.getSwatch(xIndex: xIndex, yIndex: yIndex))
                            }
                        }
                    }
                }
            }
        }
    }
}
