//
//  CGSizeExtension.swift
//  andus
//
//  Created by Adriano Oliviero on 02/04/26.
//

import CoreGraphics

extension CGSize {
    static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }
    static func *= (lhs: inout CGSize, rhs: CGFloat) {
        lhs.width *= rhs
        lhs.height *= rhs
    }
}
