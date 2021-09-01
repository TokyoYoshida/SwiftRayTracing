//
//  Ray.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/31.
//

import Foundation

struct Ray {
    let orig: Point3
    let dir: Vec3

    public var origin: Point3 {
        orig
    }

    public var direction: Vec3 {
        dir
    }

    public func at(_ t: Double) -> Point3 {
        orig + t * dir
    }
}
