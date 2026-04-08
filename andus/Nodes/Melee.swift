//
//  HitboxMelee.swift
//  andus
//
//  Created by Andreina Costagliola on 01/04/26.
//

import Foundation
import GameplayKit
import SpriteKit

class Melee: SKNode {
    var spriteComponent: SpriteComponent?

    init(imageNamed: String, contactTestBitMask: UInt32) {
        super.init()
        self.spriteComponent = .init(texture: SKTexture(imageNamed: imageNamed))
        guard let spriteComponent else { return }
        let node = spriteComponent.node
        node.zPosition = -0.1

        if let texture = node.texture {
            node.physicsBody = SKPhysicsBody(rectangleOf: texture.size())
            guard let body = node.physicsBody else { return }
            body.isDynamic = true
            body.affectedByGravity = false
            body.pinned = true
            body.categoryBitMask = CollisionBitMasks.melee
            body.contactTestBitMask = contactTestBitMask
            body.collisionBitMask = 0

            body.mass = 0
            body.linearDamping = 0
            body.angularDamping = 0
            body.friction = 0
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
