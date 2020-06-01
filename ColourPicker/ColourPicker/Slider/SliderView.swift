//
//  SliderView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI


struct SliderView: View {
  internal init(parameter: Parameter, orientation: Axis, thickness: CGFloat, length: CGFloat, value: Binding<Double>) {
    self.parameter = parameter
    self.orientation = orientation
    self.gradient = orientation == .horizontal ? parameter.horizontalGradient : parameter.verticalGradient
    self.thickness = thickness
    self.length = length
    self._value = value
  }
  
  let parameter: Parameter
  let orientation: Axis
  @Binding var value: Double
  let gradient: LinearGradient
  let thickness: CGFloat
  let length: CGFloat
  
  
  func size(in direction: Axis) -> CGFloat {
    if orientation == direction {
      return length
    }
    else {
      return thickness
    }
  }
  
  var body: some View {
      ZStack {
        if self.parameter == .alpha {
        TransparencyCheckerboardView()
          .frame(width: size(in: .horizontal), height: size(in: .vertical), alignment: .center)
          .cornerRadius(thickness / 4)
        } else {
          Color.white
          .frame(width: size(in: .horizontal), height: size(in: .vertical), alignment: .center)
        }
        self.gradient
          .frame(width: size(in: .horizontal), height: size(in: .vertical), alignment: .center)
          .cornerRadius(thickness / 4)
        SliderThumbView(length: size(in: orientation), value: self.$value, orientation: self.orientation)
      }
    .padding()
  }
}

struct SliderThumbView: View {
  let length: CGFloat
  @Binding var value: Double
  let orientation: Axis
  var body: some View {
    Group {
      Capsule()
        .stroke(lineWidth: 5)
        .frame(width: self.orientation == .horizontal ? 10 : 70, height: self.orientation == .horizontal ? 70 : 10)
        .drag(value: self.$value, length: length, orientation: orientation)
    }
    .frame(maxWidth: orientation == .horizontal ? .infinity : 70, maxHeight: orientation == .horizontal ? 70 : .infinity, alignment: orientation == .horizontal ? .leading : .top)
  }
}

struct SliderView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
