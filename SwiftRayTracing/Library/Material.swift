//
//  Material.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/09/05.
//

import Foundation

protocol Material {
    func scatter(rIn: Ray, rec: HitRecord, attenuation: Color, scatterd: inout Ray) -> Bool
}
