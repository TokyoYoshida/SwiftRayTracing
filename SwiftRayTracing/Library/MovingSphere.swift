//
//  MovingSphere.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/11.
//

import Foundation

class MovingSphere {
    private var center0, center1: Point3
    private var time0, time1: Double
    private var radius: Double
    private var mat: Material

    internal init(center0: Point3, center1: Point3, time0: Double, time1: Double, radius: Double, mat: Material) {
        self.center0 = center0
        self.center1 = center1
        self.time0 = time0
        self.time1 = time1
        self.radius = radius
        self.mat = mat
    }

    func center(time: Double) -> Point3 {
        center0 + ((time - time0) / (time1 - time0)) * (center1 - center0)
    }
}

extension MovingSphere: Hittable {
    func hit(r: Ray, tMin: Double, tMax: Double, rec: inout HitRecord) -> Bool {
        let oc = r.origin - center(time: r.time)
        let a = r.direction.lengthSquared
        let halfB = dot(oc, r.direction)
        let c = oc.lengthSquared - radius * radius
        let discriminant = halfB * halfB - a * c

        if discriminant > 0 {
            let root = sqrt(discriminant)
            var temp = (-halfB - root) / a
            if temp < tMax, temp > tMin {
                rec.t = temp
                rec.p = r.at(rec.t)
                let outwardNormal = (rec.p - center(time: r.time)) / radius
                rec.setFaceNormal(r: r, outwardNormal: outwardNormal)
                rec.mat = mat
                return true
            }
            temp = (-halfB + root) / a
            if temp < tMax, temp > tMin {
                rec.t = temp
                rec.p = r.at(rec.t)
                let outwardNormal = (rec.p - center(time: r.time)) / radius
                rec.setFaceNormal(r: r, outwardNormal: outwardNormal)
                rec.mat = mat
                return true
            }
        }
        return false
    }

}
