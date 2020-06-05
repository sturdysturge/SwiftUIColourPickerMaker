//
//  PalettePickable.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

protocol PalettePickable {
    associatedtype ValueType where ValueType: PaletteDataStorable
    var data: ValueType { get }
}

extension PalettePickable where Self: View {
    var body: some View {
        VStack {
            ForEach(0 ..< data.size.rows, id: \.self) {
                yIndex in
                HStack {
                    ForEach(0 ..< self.data.size.columns, id: \.self) {
                        xIndex in
                        Button(action: {
                            let swatch = self.data.getSwatch(xIndex: xIndex, yIndex: yIndex)
                            self.data.bindingValues().0.wrappedValue = self.data.getSwatchParameter(.horizontal, swatch: swatch)
                            self.data.bindingValues().1.wrappedValue = self.data.getSwatchParameter(.vertical, swatch: swatch)
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
