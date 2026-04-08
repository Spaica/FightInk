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

    init(imageNamed: String) {
        super.init()
        self.spriteComponent = .init(texture: SKTexture(imageNamed: imageNamed))
        guard let spriteComponent else { return }
        let node = spriteComponent.node
        node.zPosition = -0.1

        if let texture = node.texture {
            node.physicsBody = SKPhysicsBody(rectangleOf: texture.size())
            node.physicsBody?.isDynamic = false
            node.physicsBody?.categoryBitMask = CollisionBitMasks.melee
            node.physicsBody?.contactTestBitMask =
                CollisionBitMasks.monster
            node.physicsBody?.collisionBitMask = 0
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
