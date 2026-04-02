//
//  Enemy.swift
//  andus
//
//  Created by Adriano Oliviero on 01/04/26.
//

import GameKit

class Enemy: GKEntity {
    var spriteComponent = SpriteComponent(
        texture: SKTexture(imageNamed: "enemy"),
    )

    override init() {
        super.init()
        spriteComponent.node.setScale(0.1)
        spriteComponent.node.physicsBody = .init(
            rectangleOf: spriteComponent.node.size
        )
        spriteComponent.node.position = .init(x: 200, y: 0)
        spriteComponent.node.physicsBody?.isDynamic = true
        spriteComponent.node.physicsBody?.affectedByGravity = false
        spriteComponent.node.physicsBody?.node?.zPosition = 1
        addComponent(spriteComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
