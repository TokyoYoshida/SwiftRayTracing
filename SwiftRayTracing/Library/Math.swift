//
//  Math.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/31.
//

import Foundation

func dot(_ u: Vec3, _ v: Vec3) -> Double {
    return u.x * v.x +
        u.y * v.y +
        u.z * v.z
}

func unitVector(v: Vec3) -> Vec3 {
    return v / v.length
}
