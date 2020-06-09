//  SliderPickable.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

/// Requirements for all sliders
protocol SliderPickable: View {
  /// The type of data that stores the binding
  associatedtype DataType where DataType: SliderDataBindable
  /// The data that stores the binding
  var data: DataType { get }
  /// The shorter dimension of the slider
    var thickness: CGFloat { get }
  /// The longer dimension of the slider
    var length: CGFloat { get }
  /// A State for the slider position indicator
    var thumbOffset: CGPoint { get }
  /// A Binding of the above State to be passed to the .drag modifier
    var _$thumbOffset: Binding<CGPoint> { get }
  /// The appropriate value for a dimension based on orientation
  /// - Parameter direction: Which dimension is required
    func size(in direction: Axis) -> CGFloat
}

extension SliderPickable {
    func size(in direction: Axis) -> CGFloat {
      if data.orientation == direction {
            return length
        } else {
            return thickness
        }
    }

    var body: some View {
        ZStack {
          if self.data.parameter == .alpha {
                TransparencyCheckerboardView()
                    .frame(width: size(in: .horizontal), height: size(in: .vertical), alignment: .center)
                    .cornerRadius(thickness / 4)
          }
          self.data.linearGradient
                .frame(width: size(in: .horizontal), height: size(in: .vertical), alignment: .center)
                .cornerRadius(thickness / 4)
            .drag(value: self.data.getBindingValue(), offset: self._$thumbOffset, length: length, orientation: data.orientation)
          SliderThumbView(orientation: data.orientation, length: thickness + 5, thickness: 15)
            .frame(width: size(in: .horizontal), height: size(in: .vertical), alignment: .center)
                .offset(x: self.thumbOffset.x, y: self.thumbOffset.y)
        }
    }
}
