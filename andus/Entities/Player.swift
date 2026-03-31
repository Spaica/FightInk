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
        self.spriteComponent.node.physicsBody?.linearDamping = 10
        self.spriteComponent.node.physicsBody?.allowsRotation = false
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
            let speed: CGFloat = 40000
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
