//
//  Metal.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/05.
//

import Foundation

class Metal: Material {
    var albedo: Color
    var fuzz: Double

    internal init(albedo: Color, fuzz: Double) {
        self.albedo = albedo
        self.fuzz = fuzz < 1 ? fuzz : 1
    }

    func scatter(rIn: Ray, rec: HitRecord, attenuation: inout Color, scatterd: inout Ray) -> Bool {
        let refrected = refrect(v: unitVector(v: rIn.direction), n: rec.normal)
        scatterd = Ray(orig: rec.p, dir: refrected + fuzz * randomInUnitSphere())
        attenuation = albedo
        return dot(scatterd.direction, rec.normal) > 0
    }
}
