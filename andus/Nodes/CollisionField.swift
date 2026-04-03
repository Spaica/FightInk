//
//  CollisionField.swift
//  andus
//
//  Created by Adriano Oliviero on 02/04/26.
//

import GameplayKit
import SpriteKit

class CollisionField: SKNode {
    let node = SKFieldNode.radialGravityField()
    var radius: Float {
        didSet {
            self.node.region = .init(radius: radius)
        }
    }
    var categoryBitMask: UInt32 {
        didSet {
            self.node.categoryBitMask = categoryBitMask
        }
    }

    override init() {
        self.radius = 10
        self.categoryBitMask = 0b0
        super.init()

        self.node.falloff = 2.0
        self.node.strength = -2000.0
        self.node.minimumRadius = 0.0
        self.addChild(self.node)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
