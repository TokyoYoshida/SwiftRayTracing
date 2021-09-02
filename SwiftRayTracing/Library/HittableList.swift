//
//  HittableList.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/02.
//

import Foundation

class HittableList {
    var objects: [Hittable] = []

    public func add(_ object: Hittable) {
        objects.append(object)
    }
}

extension HittableList: Hittable {
    public func hit(r: Ray, tMin: Double, tMax: Double, rec: inout HitRecord) -> Bool {
        var tempRec = HitRecord()
        var hitAnything = false
        var closestSoFar = tMax

        for object in objects {
            if object.hit(r: r, tMin: tMin, tMax: closestSoFar, rec: &tempRec) {
                hitAnything = true
                closestSoFar = tempRec.t
                rec = tempRec
            }
        }

        return hitAnything
    }
}
