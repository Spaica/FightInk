//
//  CGVectorExtension.swift
//  andus
//
//  Created by Adriano Oliviero on 31/03/26.
//

import CoreGraphics

extension CGVector {
    static func + (lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }
    static func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }
    static func += (lhs: inout CGVector, rhs: CGVector) {
        lhs.dx += rhs.dx
        lhs.dy += rhs.dy
    }
    static func /= (lhs: inout CGVector, rhs: CGFloat) {
        lhs.dx /= rhs
        lhs.dy /= rhs
    }
    static func *= (lhs: inout CGVector, rhs: CGFloat) {
        lhs.dx *= rhs
        lhs.dy *= rhs
    }
}
