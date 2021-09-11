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
    let time: Double

    internal init(orig: Point3, dir: Vec3, time: Double = 0) {
        self.orig = orig
        self.dir = dir
        self.time = time
    }

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
