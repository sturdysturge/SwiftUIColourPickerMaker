//  CircleThumbView.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import SwiftUI

public struct CircleThumbView {
    let size: CGFloat
}

extension CircleThumbView: View {
  public var body: some View {
        ZStack {
            Group {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.white)
                Circle()
                    .stroke(lineWidth: 5)
                    .foregroundColor(.black)
            }
            .frame(width: self.size, height: self.size)
        }
    }
}

struct CircleThumbView_Previews: PreviewProvider {
    static var previews: some View {
        CircleThumbView(size: 25)
    }
}
