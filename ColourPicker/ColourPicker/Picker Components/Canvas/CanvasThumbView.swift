//
//  CanvasThumbView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 02/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct CanvasThumbView: View {
    let size: CGSize
    @Binding var xValue: Double
    @Binding var yValue: Double
    var body: some View {
        Group {
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 25, height: 25)
                .bidirectionalDrag(xValue: self.$xValue, yValue: self.$yValue, size: self.size)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct CanvasThumbView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasThumbView(size: CGSize(), xValue: .constant(0.5), yValue: .constant(0.5))
    }
}
