//
//  Player.swift
//  andus
//
//  Created by Andreina Costagliola on 30/03/26.
//

import Foundation
import GameplayKit
import SpriteKit

class Player: GKEntity {
    var spriteComponent = SpriteComponent(
        texture: SKTexture(imageNamed: "player")
    )
    var fieldNode = CollisionField()
    var moving = (w: false, a: false, s: false, d: false)

    override init() {
        super.init()
        self.spriteComponent.node.physicsBody = .init(
            rectangleOf: self.spriteComponent.node.size
        )
        guard let body = self.spriteComponent.node.physicsBody else { return }
        body.affectedByGravity = false
        body.linearDamping = 10
        body.allowsRotation = false
        body.categoryBitMask = CollisionBitMasks.player
        body.collisionBitMask = CollisionBitMasks.worldBorder
        body.fieldBitMask = CollisionBitMasks.enemy

        self.spriteComponent.node.zRotation = CGFloat.pi / 2
        self.spriteComponent.node.zPosition = 2
        self.spriteComponent.node.setScale(0.5)

        self.fieldNode.size = self.spriteComponent.node.size
        self.spriteComponent.node.physicsBody?.node?.addChild(self.fieldNode)

        addComponent(self.spriteComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        move(deltaTime: seconds)
    }

    func move(deltaTime seconds: TimeInterval) {
        if let body = self.spriteComponent.node.physicsBody {
            let speed: CGFloat = 10000
            body.velocity +=
                CGVector(
                    dx: (moving.d ? speed : 0)
                        + (moving.a ? -speed : 0),
                    dy: (moving.w ? speed : 0)
                        + (moving.s ? -speed : 0)
                ) * seconds
            //                if (moving.a || moving.d) && (moving.w || moving.s) {
            //                    body.velocity.dx = sqrt(body.velocity.dx)
            //                    body.velocity.dy = sqrt(body.velocity.dy)
            //                }
        }
    }
}
