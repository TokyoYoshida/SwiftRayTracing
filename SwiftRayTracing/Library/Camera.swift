//
//  Camera.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/02.
//

import Foundation

class Camera {
    private var origin: Point3
    private var lowerLeftCorner: Point3
    private var horizonal: Vec3
    private var vertical: Vec3
    private var u, v, w: Vec3
    private var lensRadius: Double

    init(lookfrom: Point3, lookat: Point3, vup: Vec3, vfov: Double, aspectRatio: Double, aperture: Double, focusDist: Double) {
        let theta = degreesToRadians(degrees: vfov)
        let h = tan(theta / 2)
        let viewportHeight = 2.0 * h
        let viewportWidth = aspectRatio * viewportHeight

        w = unitVector(v: lookfrom - lookat)
        u = unitVector(v: cross(vup, w))
        v = cross(w, u)

        origin = lookfrom
        horizonal = focusDist * viewportWidth * u
        vertical = focusDist * viewportHeight * v
        lowerLeftCorner = origin - horizonal / 2 - vertical / 2 - focusDist * w

        lensRadius = aperture / 2
    }

    public func getRay(s: Double, t: Double) -> Ray {
        let rd = lensRadius * randomInUnitDesk()
        let offset: Vec3 = u * rd.x + v * rd.y
        return Ray(orig: origin + offset,
                   dir: lowerLeftCorner + s * horizonal + t * vertical - origin - offset)
    }
}
