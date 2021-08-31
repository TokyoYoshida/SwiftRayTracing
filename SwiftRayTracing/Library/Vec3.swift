//
//  vec3.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/29.
//

import Foundation

struct Vec3 {
    public var x: Double
    public var y: Double
    public var z: Double

    public var length: Double {
        sqrt(lengthSquared)
    }

    public var lengthSquared: Double {
        x*x + y*y + z*z
    }

    init(_ x: Double, _ y: Double, _ z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
}

func + (lhs: Vec3, rhs: Vec3) -> Vec3 {
    var result = lhs
    result.x += rhs.x
    result.y += rhs.y
    result.z += rhs.z
    return result
}

func - (lhs: Vec3, rhs: Vec3) -> Vec3 {
    var result = lhs
    result.x -= rhs.x
    result.y -= rhs.y
    result.z -= rhs.z
    return result
}

func * (t: Double, v: Vec3) -> Vec3 {
    return Vec3(v.x*t, v.y*t, v.z*t)
}

func * (v: Vec3, t: Double) -> Vec3 {
    return t * v
}

func / (v: Vec3, t: Double) -> Vec3 {
    return (1/t) * v
}

typealias Point3 = Vec3
