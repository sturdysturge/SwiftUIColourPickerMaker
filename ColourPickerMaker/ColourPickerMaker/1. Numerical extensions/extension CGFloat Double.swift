//  extension CGFloat Double.swift
//  ColourPickerMaker
//
//  Created by Rob Sturgeon on 09/06/2020.
//  Copyright © 2020 Rob Sturgeon. All rights reserved.
//
//  Released under the MIT license
//  https://sturdysturge.com/mit/

import CoreGraphics

extension CGFloat {
    static let halfPi: CGFloat = 1.5707963267948966
    static let doublePi: CGFloat = 6.283185307179586
    func clampFrom(_ minValue: CGFloat, to maxValue: CGFloat) -> CGFloat {
        return [[minValue, self].max() ?? self, maxValue].min() ?? self
    }

    func clampFromZero(to maxValue: CGFloat) -> CGFloat {
        return [[0, self].max() ?? self, maxValue].min() ?? self
    }
}

extension Double {
    func clampFrom(min minValue: Double, to maxValue: Double) -> Double {
        return [[minValue, self].max() ?? self, maxValue].min() ?? self
    }

    func clampFromZero(to maxValue: Double) -> Double {
        return [[0, self].max() ?? self, maxValue].min() ?? self
    }
}

extension CGPoint {
    func angleToPoint(_ point: CGPoint) -> CGFloat {
        let xDistance = point.x - x
        let yDistance = point.y - y
        var radians = CGFloat.halfPi + (CGFloat.halfPi - atan2(xDistance, yDistance))

        while radians < 0 {
            radians += CGFloat.doublePi
        }

        return radians
    }

    func distanceToPoint(otherPoint: CGPoint) -> CGFloat {
        return sqrt(pow(otherPoint.x - x, 2) + pow(otherPoint.y - y, 2))
    }
}
