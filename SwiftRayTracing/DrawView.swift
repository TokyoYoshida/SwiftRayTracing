//
//  DrawView.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/29.
//

import UIKit

class DrawView: UIView {
    override func draw(_ rect: CGRect) {
        //        drawGradation()
        //        rayColorBackGround()
        rayColorSphere()
    }

    private func drawGradation() {
        let imageWidth = 256
        let imageHeght = 256
        let drawer = Drawer(destView: self, width: imageWidth, height: imageHeght)

        for j in 0..<imageHeght {
            for i in 0..<imageWidth {
                let color = Color(Double(i) / (Double(imageWidth) - 1), Double(j) / (Double(imageHeght) - 1), 0.25)
                drawer.draw(color: color)
            }
        }
    }

    private func rayColorBackGround() {
        func rayColor(r: Ray) -> Color {
            let unitDirection = unitVector(v: r.direction)
            let t = 0.5 * (unitDirection.y + 1.0)
            return (1.0 - t) * Color(1, 1, 1) + t * Color(0.5, 0.7, 1.0)
        }

        let aspectRatio = 16.0 / 9.0
        let imageWidth = 384
        let imageHeght = Int(Double(imageWidth) / aspectRatio)
        let drawer = Drawer(destView: self, width: imageWidth, height: imageHeght)

        let viewportHeight = 2.0
        let viewportWidth = aspectRatio * viewportHeight
        let fcalLength = 1.0

        let origin = Point3(0, 0, 0)
        let horizonal = Vec3(viewportWidth, 0, 0)
        let vertical = Vec3(0, viewportHeight, 0)
        let lowerLeftCenter = origin - horizonal / 2 - vertical / 2 - Vec3(0, 0, fcalLength)
        for j in stride(from: imageHeght - 1, to: 0, by: -1) {
            for i in 0..<imageWidth {
                let u = Double(i) / (Double(imageWidth) - 1)
                let v = Double(j) / (Double(imageHeght) - 1)
                let r = Ray(orig: origin, dir: lowerLeftCenter + u * horizonal + v * vertical - origin)
                let pixcelColor = rayColor(r: r)
                drawer.draw(color: pixcelColor)
            }
        }
    }

    private func rayColorSphere() {
        func hitSphere(center: Point3, radius: Double, r: Ray) -> Bool {
            let oc = r.origin - center
            let a = dot(r.direction, r.direction)
            let b = 2.0 * dot(oc, r.direction)
            let c = dot(oc, oc) - radius * radius
            let discriminant = b * b - 4 * a * c
            return discriminant > 0
        }
        func rayColor(r: Ray) -> Color {
            if hitSphere(center: Point3(0, 0, -1), radius: 0.5, r: r) {
                return Color(1, 0, 0)
            }
            let unitDirection = unitVector(v: r.direction)
            let t = 0.5 * (unitDirection.y + 1.0)
            return (1.0 - t) * Color(1, 1, 1) + t * Color(0.5, 0.7, 1.0)
        }

        let aspectRatio = 16.0 / 9.0
        let imageWidth = 384
        let imageHeght = Int(Double(imageWidth) / aspectRatio)
        let drawer = Drawer(destView: self, width: imageWidth, height: imageHeght)

        let viewportHeight = 2.0
        let viewportWidth = aspectRatio * viewportHeight
        let fcalLength = 1.0

        let origin = Point3(0, 0, 0)
        let horizonal = Vec3(viewportWidth, 0, 0)
        let vertical = Vec3(0, viewportHeight, 0)
        let lowerLeftCenter = origin - horizonal / 2 - vertical / 2 - Vec3(0, 0, fcalLength)
        for j in stride(from: imageHeght - 1, to: 0, by: -1) {
            for i in 0..<imageWidth {
                let u = Double(i) / (Double(imageWidth) - 1)
                let v = Double(j) / (Double(imageHeght) - 1)
                let r = Ray(orig: origin, dir: lowerLeftCenter + u * horizonal + v * vertical - origin)
                let pixcelColor = rayColor(r: r)
                drawer.draw(color: pixcelColor)
            }
        }
    }
}
