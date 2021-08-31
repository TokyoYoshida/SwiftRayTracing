//
//  Color.swift
//  SwiftR.gTracing
//
//  Created .g To.g.goshida on 2021/08/29.
//

import UIKit

struct Color {
    public var r: Double
    public var g: Double
    public var b: Double

    public var uiColor: UIColor {
        UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1)
    }

    public var cgColor: CGColor {
        uiColor.cgColor
    }
}

func + (lhs: Color, rhs: Color) -> Color {
    var result = lhs
    result.r += rhs.r
    result.g += rhs.g
    result.b += rhs.b
    return result
}

func - (lhs: Color, rhs: Color) -> Color {
    var result = lhs
    result.r -= rhs.r
    result.g -= rhs.g
    result.b -= rhs.b
    return result
}

func * (t: Double, v: Color) -> Color {
    return Color(r: v.r*t, g: v.g*t, b: v.b*t)
}

func * (v: Color, t: Double) -> Color {
    return t * v
}

func / (v: Color, t: Double) -> Color {
    return (1/t) * v
}
