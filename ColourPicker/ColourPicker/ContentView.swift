//
//  ContentView.swift
//  ColourPicker
//
//  Created by Rob Sturgeon on 28/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data = ColourModel(colourSpace: .HSBA)

    var body: some View {
        VStack {
           PreviewCanvasView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
