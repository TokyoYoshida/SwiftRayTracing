//
//  Math.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/31.
//

import Foundation

let infinity = Double.infinity
let pi = 3.1415926535897932385

func degreesToRadians(degrees: Double) -> Double {
    return degrees * pi / 180
}

func dot(_ u: Vec3, _ v: Vec3) -> Double {
    return u.x * v.x +
        u.y * v.y +
        u.z * v.z
}

func unitVector(v: Vec3) -> Vec3 {
    return v / v.length
}

func randomDouble() -> Double {
    Double.random(in: 0 ..< 1)
}

func randomDouble(min: Double, max: Double) -> Double {
    min + (max - min) * randomDouble()
}

func randomInUnitSphere() -> Vec3 {
    while true {
        let p = Vec3.random(min: -1, max: 1)
        if p.lengthSquared >= 1 { continue }
        return p
    }
}

func clamp(_ x: Double, min: Double, max: Double) -> Double {
    if x < min { return min }
    if x > max { return max }
    return x
}
