//
//  SpriteComponent.swift
//  andus
//
//  Created by Andreina Costagliola on 30/03/26.
//

import Foundation
import GameplayKit
import SpriteKit

class SpriteComponent: GKComponent {
    let node: SKSpriteNode

    init(texture: SKTexture) {
        node = SKSpriteNode(
            texture: texture,
            color: .white,
            size: texture.size()
        )
        node.physicsBody = SKPhysicsBody(rectangleOf: texture.size())
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.linearDamping = 5
        super.init()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
