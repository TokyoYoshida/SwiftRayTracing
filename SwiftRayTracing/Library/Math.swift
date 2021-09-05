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

func randomInHemiSphere(normal: Vec3) -> Vec3 {
    let inUnitSphere = randomInUnitSphere()
    if dot(inUnitSphere, normal) > 0.0 {
        return inUnitSphere
    } else {
        return -1 * inUnitSphere
    }
}

func randomInUnitVector() -> Vec3 {
    let a = randomDouble(min: 0, max: 2 * pi)
    let z = randomDouble(min: -1, max: 1)
    let r = sqrt(1 - z * z)
    return Vec3(r * cos(a), r * sin(a), z)
}

func clamp(_ x: Double, min: Double, max: Double) -> Double {
    if x < min { return min }
    if x > max { return max }
    return x
}

func refrect(v: Vec3, n: Vec3) -> Vec3 {
    return v - 2 * dot(v, n) * n
}

func refract(uv: Vec3, n: Vec3, etaiOverEtat: Double) -> Vec3 {
    let cosTheta = dot(-1 * uv, n)
    let rOutParallel = etaiOverEtat * (uv * cosTheta * n)
    let rOutPerp = -1 * sqrt(1.0 - rOutParallel.lengthSquared) * n
    return rOutParallel - rOutPerp
}
