//
//  Sphere.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/02.
//

import Foundation

class Sphere {
    var center: Point3
    var radius: Double

    internal init(center: Point3, radius: Double) {
        self.center = center
        self.radius = radius
    }
}

extension Sphere: Hittable {
    func hit(r: Ray, tMin: Double, tMax: Double, rec: inout HitRecord) -> Bool {
        let oc = r.origin - center
        let a = r.direction.lengthSquared
        let halfB = dot(oc, r.direction)
        let c = oc.lengthSquared - radius * radius
        let discriminant = halfB * halfB - a * c

        if discriminant > 0 {
            let root = sqrt(discriminant)
            var temp = (-halfB - root / a)
            if temp < tMax, temp > tMin {
                rec.t = temp
                rec.p = r.at(rec.t)
                let outwardNormal = (rec.p - center) / radius
                rec.setFaceNormal(r: r, outwardNormal: outwardNormal)
                rec.normal = (rec.p - center) / radius
                return true
            }
            temp = (-halfB + root) / a
            if temp < tMax, temp > tMin {
                rec.t = temp
                rec.p = r.at(rec.t)
                let outwardNormal = (rec.p - center) / radius
                rec.setFaceNormal(r: r, outwardNormal: outwardNormal)
                rec.normal = (rec.p - center) / radius
                return true
            }
        }
        return false
    }
}
