//
//  HittableList.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/02.
//

import Foundation

class HittableList {
    var objects: [Hittable] = []
}

extension HittableList: Hittable {
    func hit(r: Ray, tMin: Double, tMax: Double, rec: inout HitRecord) -> Bool {
        var tempRec = HitRecord()
        var hitAnything = false
        //        var closestSoFar = tMax

        for object in objects {
            if object.hit(r: r, tMin: tMin, tMax: tMax, rec: &tempRec) {
                hitAnything = true
                //                closestSoFar = tempRec.t
                rec = tempRec
            }
        }

        return hitAnything
    }
}
