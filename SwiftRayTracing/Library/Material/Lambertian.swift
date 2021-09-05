//
//  Lambertian.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/05.
//

import Foundation

class Lambertian: Material {
    var albedo: Color

    internal init(albedo: Color) {
        self.albedo = albedo
    }

    func scatter(rIn: Ray, rec: HitRecord, attenuation: inout Color, scatterd: inout Ray) -> Bool {
        let scatterDirection = rec.normal + randomInUnitVector()
        scatterd = Ray(orig: rec.p, dir: scatterDirection)
        attenuation = albedo
        return true
    }

}
