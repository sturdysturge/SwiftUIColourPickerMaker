//
//  WheelView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 04/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

public struct WheelView: View {
    let angularGradient: Gradient
    let radialGradient: Gradient
    @Binding var rotation: Double
    @Binding var distanceFromCentre: Double
  @State var thumbOffset = CGPoint()
    public var body: some View {
        
            ZStack {
              GeometryReader { geometry in
                AngularGradient(gradient: self.angularGradient, center: .center, startAngle: .degrees(-89), endAngle: .degrees(270))
                .clipShape(Circle())
                RadialGradient(gradient: self.radialGradient, center: .center, startRadius: 10, endRadius: geometry.size.width * 0.7)
                .clipShape(Circle())
                  .radialDrag(rotation: self.$rotation, distanceFromCentre: self.$distanceFromCentre, size: geometry.size, offset: self.$thumbOffset)
                Group {
                    Circle()
                        .stroke(lineWidth: 5)
                        .frame(width: 25, height: 25)
                      .offset(x: self.thumbOffset.x, y: self.thumbOffset.y)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
              
            
        }
      .aspectRatio(1, contentMode: .fit)
      
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
