//
//  DrawView.swift
//  SwiftRayTracing
//
//  Created by TokyoYoshida on 2021/08/29.
//

import UIKit

class DrawView: UIView {
    override func draw(_ rect: CGRect) {
        drawFillCircle(rect: CGRect(x: 100, y: 100, width: 100, height: 100))
    }

    private func drawFillCircle(rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.setFillColor(UIColor.red.cgColor)

        context.fillEllipse(in: rect)
    }
}
