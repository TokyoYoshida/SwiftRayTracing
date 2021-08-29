//
//  DrawView.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/29.
//

import UIKit

class DrawView: UIView {
    lazy var drawer: Drawer = Drawer(destView: self, width: 1000, height: 1000)

    override func draw(_ rect: CGRect) {
        for _ in 0...1000000 {
            drawer.draw(color: Color(r: 1, g: 0, b: 0))
        }
    }
}
