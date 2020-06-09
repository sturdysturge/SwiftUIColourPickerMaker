# Colour Picker Maker
> Create colour pickers using controls such as canvases, wheels, palettes and sliders.

[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Downloads Stats][npm-downloads]][npm-url]
This package contains sliders and controls for colour pickers that can be added to your project in any configuration. There are also example colour pickers that use these controls, so you have the choice between using existing pickers or building your own.

This package was created as part of the Medium tutorial Make 1500+ SwiftUI Colour Picker Varieties and Reuse Them In Any Project With Swift Package Manager, available here: https://medium.com/@rob_sturgeon

# Colour palettes

![Palettes](/Images/palette.png)

Choose a vertical and horizontal parameter for your palette and how many swatches there should be in a column and in a row. For instance, choosing hue vertically with 10 swatches will give one swatch at 0.0 hue, one at 0.1 hue and so on up to 1.0 hue. If saturation was chosen horizontally, the swatches would change from 0.0 to 1.0 saturation in the horizontal direction.

Increasing the number of swatches decreases the difference between each swatch, leading to more variations being covered.

# Colour canvases

![Canvases](/Images/canvas.png)

If the X axis is brightness and the Y axis is saturation, the coordinates of the point you pick will set both of these parameters.

# Colour sliders

![Canvases](/Images/sliders.png)

Any slider can be used in the horizontal or vertical position, and gradients are added automatically based on the parameter being picked.

# Colour wheels

![Canvases](/Images/wheel.png)

Wheels use degrees of rotation instead of the X position, and distance from the centre (the radius) for a secondary parameter.

## Installation

Follow the instructions for installing a Swift Package here, using the URL
https://medium.com/better-programming/add-swift-package-dependency-to-an-ios-project-with-xcode-11-remote-local-public-private-3a7577fac6b2

## Usage examples

A few motivating and useful examples of how your product can be used. Spice this up with code blocks and potentially more screenshots.

```swift
import ColourPickerMaker
import SwiftUI

struct CanvasView: View {
  @ObservedObject var data = ColourModel(colourSpace: .RGBA)
  var body: some View {
    VStack {
      PreviewColourView(colour: data.colour, square: true)
      RGBACanvasView(data: RGBAData(values: $data.valuesInRGBA, parameters: (.red, .green)))
    }
  }
}

struct SliderView: View {
  @ObservedObject var data = ColourModel(colourSpace: .RGBA)
  var body: some View {
    VStack {
      PreviewColourView(colour: data.colour, square: true)
      RGBASliderView(data: RGBASliderData(values: $data.valuesInRGBA, parameter: .red, orientation: .horizontal), thickness: 50, length: 300)
  }
}

struct WheelView: View {
    @ObservedObject var data = ColourModel(colourSpace: .HSBA)
  
    var body: some View {
        VStack {
            PreviewColourView(colour: data.colour, square: true)
            HSBAWheelView(data: HSBAData(values: $data.valuesInHSBA, parameters: (.hue, .saturation)))
        }
    }
}

struct PaletteView: View {
  @ObservedObject var data = ColourModel(colourSpace: .HSBA)
  
  var body: some View {
    HSBAPaletteView(data: HSBAData(values: $data.valuesInHSBA, parameters: (.hue, .saturation)))
  }
}
```

## Release History

* 1.0
    * Pending tutorial release

## Meta

Rob Sturgeon – [@SturdySturge](https://twitter.com/sturdysturge) – github@sturdysturge.com

Distributed under the MIT license. See ``LICENSE`` for more information.

## Contributing

1. Fork it (<https://github.com/sturdysturge/SwiftUIColourPickerMaker/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

<!-- Markdown link & img dfn's -->
[license-image]: https://img.shields.io/github/license/sturdysturge/SwiftUIColourPickerMaker
