//
//  ContentView.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 23/05/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//

import SwiftUI
import ColourPickerMakerPackage
 struct ContentView: View {
   var body: some View {
    GridBackgroundView(squareSize: 20)
    }
}

 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
