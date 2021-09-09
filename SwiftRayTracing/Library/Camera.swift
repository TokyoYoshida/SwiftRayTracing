//
//  Camera.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/02.
//

import Foundation

class Camera {
    private var lookfrom: Point3
    private var lookat: Point3
    private var vup: Vec3
    private var vfov: Double
    private var aspectRatio: Double
    private var origin: Point3
    private var lowerLeftCorner: Point3
    private var horizonal: Vec3
    private var vertical: Vec3

    init(lookfrom: Point3, lookat: Point3, vup: Vec3, vfov: Double, aspectRatio: Double) {
        self.lookfrom = lookfrom
        self.lookat = lookat
        self.vup = vup
        self.vfov = vfov
        self.aspectRatio = aspectRatio

        let theta = degreesToRadians(degrees: vfov)
        let h = tan(theta / 2)
        let viewportHeight = 2.0 * h
        let viewportWidth = aspectRatio * viewportHeight

        let w = unitVector(v: lookfrom - lookat)
        let u = unitVector(v: cross(vup, w))
        let v = cross(w, u)

        origin = lookfrom
        horizonal = viewportWidth * u
        vertical = viewportHeight * v
        lowerLeftCorner = origin - horizonal / 2 - vertical / 2 - w
    }

    public func getRay(u: Double, v: Double) -> Ray {
        Ray(orig: origin, dir: lowerLeftCorner + u * horizonal + v * vertical - origin)
    }
}
