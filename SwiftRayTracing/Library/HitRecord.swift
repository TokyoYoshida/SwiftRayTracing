//
//  HitRecord.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/02.
//

import Foundation

class HitRecord {
    var p = Point3(0, 0, 0)
    var normal = Vec3(0, 0, 0)
    var t: Double = 0
    var frontFace: Bool = false
    var mat: Material?

    func setFaceNormal(r: Ray, outwardNormal: Vec3) {
        frontFace = dot(r.direction, outwardNormal) < 0
        normal = frontFace ? outwardNormal : -1 * outwardNormal
    }
}
