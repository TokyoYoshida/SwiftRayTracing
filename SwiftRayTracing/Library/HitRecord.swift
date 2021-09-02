//
//  HitRecord.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/02.
//

import Foundation

class HitRecord {
    var p: Point3
    var normal: Vec3
    var t: Double
    var frontFace: Bool

    internal init(p: Point3, normal: Vec3, t: Double, frontFace: Bool) {
        self.p = p
        self.normal = normal
        self.t = t
        self.frontFace = frontFace
    }

    func setFaceNormal(r: Ray, outwardNormal: Vec3) {
        frontFace = dot(r.direction, outwardNormal) < 0
        normal = frontFace ? outwardNormal : -1 * outwardNormal
    }
}
