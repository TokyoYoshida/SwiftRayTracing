//
//  Camera.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/02.
//

import Foundation

class Camera {
    private var vfov: Double
    private var aspectRatio: Double
    private var origin: Point3
    private var lowerLeftCorner: Point3
    private var horizonal: Vec3
    private var vertical: Vec3

    init(vfov: Double, aspectRatio: Double) {
        self.vfov = vfov
        self.aspectRatio = aspectRatio

        let theta = degreesToRadians(degrees: vfov)
        let h = tan(theta / 2)
        let viewportHeight = 2.0 * h
        let viewportWidth = aspectRatio * viewportHeight

        let focalLength = 1.0

        origin = Point3(0, 0, 0)
        horizonal = Vec3(viewportWidth, 0, 0)
        vertical = Vec3(0, viewportHeight, 0)
        lowerLeftCorner = origin - horizonal / 2 - vertical / 2 - Vec3(0, 0, focalLength)
    }

    public func getRay(u: Double, v: Double) -> Ray {
        Ray(orig: origin, dir: lowerLeftCorner + u * horizonal + v * vertical - origin)
    }
}
