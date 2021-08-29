//
//  DrawView.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/29.
//

import UIKit

class DrawView: UIView {
    let width = 300
    let height = 300
    lazy var drawer: Drawer = Drawer(destView: self, width: width, height: height)

    override func draw(_ rect: CGRect) {
        for j in 0..<height {
            for i in 0..<width {
                let color = Color(r: CGFloat(i) / (CGFloat(width) - 1), g: CGFloat(j)/(CGFloat(height) - 1), b: 0.25)
                drawer.draw(color: color)
            }
        }
    }
}
