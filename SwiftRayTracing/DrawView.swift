//
//  DrawView.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/29.
//

import UIKit

class DrawView: UIView {
    let width = 256
    let height = 256
    lazy var drawer: Drawer = Drawer(destView: self, width: width, height: height)

    override func draw(_ rect: CGRect) {
        drawGradation()
//        drawSphere()
    }

    private func drawGradation() {
        for j in 0..<height {
            for i in 0..<width {
                let color = Color(r: Double(i / (width - 1)), g: Double(j/(height - 1)), b: 0.25)
                drawer.draw(color: color)
            }
        }
    }

    private func drawSphere(_ r: Ray) -> Color {
        func hitSphere(center: Point3, radius: Double, r: Ray) -> Bool {
            let oc = r.origin - center
            let a = dot(r.origin, r.direction)
            let b = 2.0 * dot(oc, r.direction)
            let c = dot(oc, oc) - radius*radius
            let discriminant = b*b - 4*a*c
            return discriminant > 0
        }
        if  hitSphere(center: Point3(0, 0, -1), radius: 0.5, r: r) {
            return Color(r: 1, g: 0, b: 0)
        }
        let unitDirection = unitVector(v: r.direction)
        let t = 0.5 * (unitDirection.y + 1.0)

        return (1.0 - t) * Color(r: 1, g: 1, b: 1) + t * Color(r: 0.5, g: 0.7, b: 1.0)
    }
}
