//
//  Metal.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/05.
//

import Foundation

class Metal: Material {
    var albedo: Color
    
    internal init(albedo: Color) {
        self.albedo = albedo
    }
    
    func scatter(rIn:Ray, rec: HitRecord, attenuation: Color, scatterd: inout Ray) -> Bool {
        let refrected = refrect(v: unitVector(v: rIn.direction), n: rec.normal)
        scatterd = Ray(orig: rec.p, dir: refrected)
        attenuation = albedo
        return dot(scatterd.direction, rec.normal) > 0
    }
    
}
