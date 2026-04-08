//
//  CGPointExtension.swift
//  andus
//
//  Created by Adriano Oliviero on 1/04/26.
//

import CoreGraphics

extension CGPoint {
    func distance(to: CGPoint) -> CGFloat {
        return sqrt(pow(to.x - self.x, 2) + pow(to.y - self.y, 2))
    }

    static func + (rhs: CGPoint, lhs: CGPoint) -> CGPoint {
        return CGPoint(x: rhs.x + lhs.x, y: rhs.y + lhs.y)
    }
}
