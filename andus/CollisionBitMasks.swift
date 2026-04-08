//
//  CollisionBitMasks.swift
//  andus
//
//  Created by Adriano Oliviero on 02/04/26.
//

import Foundation

struct CollisionBitMasks {
    static let none: UInt32 = 0
    static let player: UInt32 = 0b1
    static let monster: UInt32 = 0b10
    static let worldBorder: UInt32 = 0b100
    static let melee: UInt32 = 0b1000
}
