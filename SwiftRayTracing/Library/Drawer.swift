//
//  utility.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/29.
//

import UIKit

class Drawer {
    weak var destView: UIView?
    var width: Int
    var height: Int
    var cursorX: Int = 0
    var cursorY: Int = 0

    init(destView: UIView, width: Int, height: Int) {
        self.destView = destView
        self.width = width
        self.height = height
    }

    func draw(color: Color) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.setStrokeColor(color.cgColor)
        drawDot(context: context, x: cursorX, y: cursorY)

        cursorX += 1
        if cursorX == width {
            cursorY += 1
            cursorX = 0
        }
    }

    func draw(color: Color, samplesPerPixcel: Int) {
        var r = color.r
        var g = color.g
        var b = color.b

        let scale = 1.0 / Double(samplesPerPixcel)

        r*=scale
        g*=scale
        b*=scale

        let color = Color(256*clamp(r, min: 0, max: 0.999), 256*clamp(g, min: 0, max: 0.999), 256*clamp(b, min: 0, max: 0.999))
        draw(color: color)
    }

    func drawDot(context: CGContext, x: Int, y: Int) {
        let rect = CGRect(x: x, y: y, width: 1, height: 1)
        context.strokeEllipse(in: rect)
    }

    func initCursor() {
        cursorX = 0
        cursorY = 0
    }
}
