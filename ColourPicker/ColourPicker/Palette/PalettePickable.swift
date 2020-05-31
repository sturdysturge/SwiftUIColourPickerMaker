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
  var xValue: Double { get }
  var yValue: Double { get }
  func setValues(xValue: Double, yValue: Double)
}

extension PalettePickable where Self: View {
  var body: some View {
    VStack {
      ForEach(0 ..< data.verticalSwatches, id: \.self) {
        yIndex in
        HStack {
          ForEach(0 ..< self.data.horizontalSwatches, id: \.self) {
            xIndex in
            Button(action: {
              let swatch = self.data.getSwatch(xIndex: xIndex, yIndex: yIndex)
              self.setValues(xValue: self.data.getSwatchParameter(.horizontal, swatch: swatch), yValue:  self.data.getSwatchParameter(.vertical, swatch: swatch))
            }) {
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
