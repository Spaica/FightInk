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
    var moving = (w: false, a: false, s: false, d: false)

    override init() {
        super.init()
        self.spriteComponent.node.zRotation = CGFloat.pi / 2
        self.spriteComponent.node.setScale(0.5)
        self.spriteComponent.node.physicsBody = SKPhysicsBody(
            rectangleOf: self.spriteComponent.node.texture?.size() ?? .zero
        )
        self.spriteComponent.node.physicsBody?.affectedByGravity = false
        self.spriteComponent.node.physicsBody?.linearDamping = 50
        addComponent(self.spriteComponent)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        move(deltaTime: seconds)
    }

    func move(deltaTime seconds: TimeInterval) {
        if let body = self.spriteComponent.node.physicsBody {
            let speed: CGFloat = 50000 * seconds
            body.velocity.dx += (moving.d ? speed : 0) + (moving.a ? -speed : 0)
            body.velocity.dy += (moving.w ? speed : 0) + (moving.s ? -speed : 0)
        }
    }
}
