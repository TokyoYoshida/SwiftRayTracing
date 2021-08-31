//
//  Ray.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/31.
//

import Foundation

struct Ray {
    private let orig: Point3
    private let dir: Vec3

    public var origin: Point3 {
        orig
    }

    public var direction: Vec3 {
        dir
    }
}
