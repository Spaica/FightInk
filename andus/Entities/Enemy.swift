//
//  Enemy.swift
//  andus
//
//  Created by Adriano Oliviero on 01/04/26.
//

import GameKit

class Enemy: GKEntity {
    let spriteComponent = SpriteComponent(
        texture: SKTexture(imageNamed: "enemy"),
    )
    let fieldNode = CollisionField()
    var shouldMove: Bool = false
    var moveTarget: CGPoint = .zero
    var speed: CGFloat = 500

    override init() {
        super.init()
        spriteComponent.node.setScale(0.1)
        spriteComponent.node.position = .init(x: 200, y: 0)
        spriteComponent.node.physicsBody = .init(
            rectangleOf: spriteComponent.node.size
        )
        guard let body = spriteComponent.node.physicsBody else { return }
        body.isDynamic = true
        body.affectedByGravity = false
        body.node?.zPosition = 1
        body.linearDamping = 5
        body.categoryBitMask = CollisionBitMasks.enemy
        body.collisionBitMask = CollisionBitMasks.worldBorder
        body.fieldBitMask = CollisionBitMasks.player

        self.fieldNode.radius = Float(
            self.spriteComponent.node.texture?.size().width ?? 1000
        )
        self.fieldNode.categoryBitMask = CollisionBitMasks.enemy
        self.spriteComponent.node.addChild(self.fieldNode)

        addComponent(spriteComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        if shouldMove {
            let dis = (
                x: moveTarget.x - self.spriteComponent.node.position.x,
                y: moveTarget.y - self.spriteComponent.node.position.y
            )
            if hypot(dis.x, dis.y)
                > max(
                    self.spriteComponent.node.size.width,
                    self.spriteComponent.node.size.height
                )
            {
                let angle = atan2(dis.y, dis.x)
                if let body = self.spriteComponent.node.physicsBody {
                    body.velocity = .init(
                        dx: cos(angle) * speed,
                        dy: sin(angle) * speed
                    )
                }
            } else {
                shouldMove = false
            }
        }
    }
}
