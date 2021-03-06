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

    private func rayColor(r: Ray, world: Hittable, depth: Int) -> Color {
        guard depth > 0 else {
            return Color(0, 0, 0)
        }
        var rec = HitRecord()
        if world.hit(r: r, tMin: 0.001, tMax: infinity, rec: &rec) {
            var scattered = Ray(orig: Point3(0, 0, 0), dir: Vec3(0, 0, 0))
            var attenuation = Color(0, 0, 0)
            if let mat = rec.mat,
               mat.scatter(rIn: r, rec: rec, attenuation: &attenuation, scatterd: &scattered) {
                return attenuation * rayColor(r: scattered, world: world, depth: depth - 1)
            }
            return Color(0, 0, 0)
        }
        let unitDirection = unitVector(v: r.direction)
        let t = 0.5 * (unitDirection.y + 1.0)
        return (1.0 - t) * Color(1, 1, 1) + t * Color(0.5, 0.7, 1.0)
    }

    private func randomScene() -> HittableList {
        let world = HittableList()

        let groundMaterial = Lambertian(albedo: Color(0.5, 0.5, 0.5))
        world.add(Sphere(center: Point3(0, -1000, 0), radius: 1000, mat: groundMaterial))

        for a in -11..<11 {
            for b in -11..<11 {
                let chooseMat = randomDouble()
                let center = Point3(Double(a) + 0.9 * randomDouble(), 0.2, Double(b) + 0.9 * randomDouble())

                if (center - Vec3(4, 0.2, 0)).length > 0.9 {
                    let sphereMaterial: Material
                    if chooseMat < 0.8 {
                        let albedo = Color.random() * Color.random()
                        sphereMaterial = Lambertian(albedo: albedo)
                        world.add(Sphere(center: center, radius: 0.2, mat: sphereMaterial))
                        let center2 = center + Vec3(0, randomDouble(min: 0, max: 0.5), 0)
                        world.add(MovingSphere(center0: center, center1: center2, time0: 0, time1: 1, radius: 0.2, mat: sphereMaterial))
                    } else if chooseMat < 0.95 {
                        let albedo = Color.random(min: 0.5, max: 1)
                        let fuzz = randomDouble(min: 0, max: 0.5)
                        sphereMaterial = Metal(albedo: albedo, fuzz: fuzz)
                        world.add(Sphere(center: center, radius: 0.2, mat: sphereMaterial))
                    } else {
                        sphereMaterial = Dielectric(refIdx: 1.5)
                        world.add(Sphere(center: center, radius: 0.2, mat: sphereMaterial))
                    }
                }
            }
        }

        let material1 = Dielectric(refIdx: 1.5)
        world.add(Sphere(center: Point3(0, 1, 0), radius: 1, mat: material1))
        let material2 = Lambertian(albedo: Color(0.4, 0.2, 0.1))
        world.add(Sphere(center: Point3(-4, 1, 0), radius: 1, mat: material2))
        let material3 = Metal(albedo: Color(0.7, 0.6, 0.5), fuzz: 0.0)
        world.add(Sphere(center: Point3(4, 1, 0), radius: 1, mat: material3))

        return world
    }

    private func drawMultiple() {
        let aspectRatio = 16.0 / 9.0
        let imageWidth = 384
        let imageHeght = Int(Double(imageWidth) / aspectRatio)
        let drawer = Drawer(destView: self, width: imageWidth, height: imageHeght)

        //        let R = cos(pi / 4)
        //        let world = HittableList()
        //        world.add(Sphere(center: Point3(0, 0, -1), radius: 0.5, mat: Lambertian(albedo: Color(0.1, 0.2, 0.5))))
        //        world.add(Sphere(center: Point3(0, -100.5, -1), radius: 100, mat: Lambertian(albedo: Color(0.8, 0.8, 0))))
        //        world.add(Sphere(center: Point3(1, 0, -1), radius: 0.5, mat: Metal(albedo: Color(0.8, 0.6, 0.2), fuzz: 0.3)))
        //        world.add(Sphere(center: Point3(-1, 0, -1), radius: 0.5, mat: Dielectric(refIdx: 1.5)))
        //        world.add(Sphere(center: Point3(-1, 0, -1), radius: -0.45, mat: Dielectric(refIdx: 1.5)))

        let world = randomScene()

        let samplesPerPixcel = 1
        let lookfrom = Point3(13, 2, 3)
        let lookat = Point3(0, 0, 0)
        let vup = Vec3(0, 1, 0)
        let distToFocus = 10.0
        let aperture = 0.0

        let cam = Camera(lookfrom: lookfrom, lookat: lookat, vup: vup, vfov: 20, aspectRatio: aspectRatio, aperture: aperture, focusDist: distToFocus, t0: 0, t1: 1)

        let maxDepth = 50

        for j in stride(from: imageHeght - 1, to: 0, by: -1) {
            if j % 10 == 0 {
                let progress = Int(Double(imageHeght - 1 - j) / Double(imageHeght) * 100)
                print("progress = \(progress)%")
            }
            for i in 0..<imageWidth {
                var pixcelColor = Color(0, 0, 0)
                for _ in 0..<samplesPerPixcel {
                    let u = (Double(i) + randomDouble()) / (Double(imageWidth) - 1)
                    let v = (Double(j) + randomDouble()) / (Double(imageHeght) - 1)
                    let r = cam.getRay(s: u, t: v)
                    pixcelColor += rayColor(r: r, world: world, depth: maxDepth)
                }
                drawer.draw(color: pixcelColor, samplesPerPixcel: samplesPerPixcel)
            }
        }
    }
}
