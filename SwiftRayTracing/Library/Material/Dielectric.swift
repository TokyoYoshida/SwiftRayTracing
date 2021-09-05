//
//  Dielectric.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/05.
//

import Foundation

class Dielectric: Material {
    var refIdx: Double

    internal init(refIdx: Double) {
        self.refIdx = refIdx
    }

    func scatter(rIn: Ray, rec: HitRecord, attenuation: inout Color, scatterd: inout Ray) -> Bool {
        attenuation = Color(1, 1, 1)
        var etaiOverEtat: Double = 0.0
        if rec.frontFace {
            etaiOverEtat = 1.0 / refIdx
        } else {
            etaiOverEtat = refIdx
        }

        let unitDirection = unitVector(v: rIn.direction)
        let cosTheta = fmin(dot(-1 * unitDirection, rec.normal), 1)
        let sinTheta = sqrt(1.0 - cosTheta * cosTheta)
        if etaiOverEtat * sinTheta > 1.0 {
            let reflected = refrect(v: unitDirection, n: rec.normal)
            scatterd = Ray(orig: rec.p, dir: reflected)
            return true
        }
        let refracted = refract(uv: unitDirection, n: rec.normal, etaiOverEtat: Double(etaiOverEtat))
        scatterd = Ray(orig: rec.p, dir: refracted)
        return true
    }
}
