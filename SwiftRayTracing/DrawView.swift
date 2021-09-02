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
        //        drawSphere()
        drawMultiple()
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

    private func drawBackGround() {
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

    private func drawSphere() {
        func hitSphere(center: Point3, radius: Double, r: Ray) -> Double {
            let oc = r.origin - center
            let a = r.direction.lengthSquared
            let halfB = dot(oc, r.direction)
            let c = oc.lengthSquared - radius * radius
            let discriminant = halfB * halfB - a * c
            if discriminant < 0 {
                return -1
            } else {
                return (-halfB - sqrt(discriminant)) / a
            }
        }
        func rayColor(r: Ray) -> Color {
            var t = hitSphere(center: Point3(0, 0, -1), radius: 0.5, r: r)
            if t > 0 {
                let N = unitVector(v: r.at(t) - Vec3(0, 0, -1))
                return 0.5 * Color(N.x + 1, N.y + 1, N.z + 1)
            }
            let unitDirection = unitVector(v: r.direction)
            t = 0.5 * (unitDirection.y + 1.0)
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

    private func drawMultiple() {
        func rayColor(r: Ray, world: Hittable) -> Color {
            var rec = HitRecord()
            if world.hit(r: r, tMin: 0, tMax: infinity, rec: &rec) {
                return 0.5 * (rec.normal + Color(1, 1, 1))
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

        let world = HittableList()
        world.add(Sphere(center: Point3(0, 0, -1), radius: 0.5))
        world.add(Sphere(center: Point3(0, -100.5, -1), radius: 100))

        let samplesPerPixcel = 100
        let cam = Camera()

        for j in stride(from: imageHeght - 1, to: 0, by: -1) {
            for i in 0..<imageWidth {
                var pixcelColor = Color(0, 0, 0)
                for s in 0..<samplesPerPixcel {
                    let u = (Double(i) + randomDouble()) / (Double(imageWidth) - 1)
                    let v = (Double(j) + randomDouble()) / (Double(imageHeght) - 1)
                    let r = cam.getRay(u: u, v: v)
                    pixcelColor += rayColor(r: r, world: world)
                }
                drawer.draw(color: pixcelColor, samplesPerPixcel: samplesPerPixcel)
            }
        }
    }
}
