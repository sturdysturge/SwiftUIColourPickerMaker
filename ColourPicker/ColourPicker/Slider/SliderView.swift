//
//  SliderView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 31/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct SliderHorizontalView: View {
  let parameter: Parameter
  @Binding var value: Double
  let gradient: LinearGradient
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        if self.parameter == .alpha {
        TransparencyCheckerboardView()
          .frame(height: 50, alignment: .center)
          .cornerRadius(geometry.size.height / 4)
        } else {
          Color.white
        }
        self.gradient
          .frame(height: 50, alignment: .center)
          .cornerRadius(geometry.size.height / 4)
        SliderThumbView(length: geometry.size.width, value: self.$value, orientation: .horizontal)
      }
    }
    .frame(height: 70)
    .padding()
  }
}

struct SliderView: View {
  let parameter: Parameter
  @Binding var value: Double
  let gradient: LinearGradient
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        if self.parameter == .alpha {
        TransparencyCheckerboardView()
          .frame(width: 50, height: 300, alignment: .center)
          .cornerRadius(geometry.size.height / 4)
        } else {
          Color.white
        }
        self.gradient
          .frame(width: 50, height: 300, alignment: .center)
          .cornerRadius(geometry.size.height / 4)
        SliderThumbView(length: geometry.size.height, value: self.$value, orientation: .vertical)
      }
      
    }
      .frame(width: 50, height: 300, alignment: .center)
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
        .drag(value: self.$value, length: length, orientation: .vertical)
    }
    .frame(maxWidth: orientation == .horizontal ? .infinity : 70, maxHeight: orientation == .horizontal ? 70 : .infinity, alignment: orientation == .horizontal ? .leading : .top)
  }
}

struct SliderView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
