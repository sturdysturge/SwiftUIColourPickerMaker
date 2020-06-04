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
    public var body: some View {
        
            ZStack {
              GeometryReader { geometry in
              AngularGradient(gradient: self.angularGradient, center: .center)
                .clipShape(Circle())
              RadialGradient(gradient: self.radialGradient, center: .center, startRadius: 0, endRadius: geometry.size.width)
                .clipShape(Circle())
                Group {
                    Circle()
                        .stroke(lineWidth: 5)
                        .frame(width: 25, height: 25)
                        .radialDrag(rotation: self.$rotation, distanceFromCentre: self.$distanceFromCentre, size: geometry.size)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
              .border(Color.red)
              
            
        }
      .aspectRatio(1, contentMode: .fit)
      
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
