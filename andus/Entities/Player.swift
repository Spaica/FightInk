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
    var hasAttacked: Bool = true

    override init() {
        super.init()
        self.spriteComponent.node.physicsBody = SKPhysicsBody(
            rectangleOf: self.spriteComponent.node.texture?.size() ?? .zero
        )
        self.spriteComponent.node.physicsBody?.affectedByGravity = false
        self.spriteComponent.node.physicsBody?.linearDamping = 10
        self.spriteComponent.node.physicsBody?.allowsRotation = false

        self.spriteComponent.node.zRotation = CGFloat.pi / 2
        self.spriteComponent.node.setScale(0.5)
        addComponent(self.spriteComponent)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        move(deltaTime: seconds)
        if !self.hasAttacked {
            attack()
        }
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

    func attack() {
        guard !hasAttacked else { return }
        hasAttacked = true

        var position = CGPoint.zero
        let range: CGFloat = 100
        let melee = Melee()
        let meleeAttack = melee.spriteComponent.node

        switch (moving.w, moving.a, moving.s, moving.d) {
        case (true, false, false, false):
            position.x += range
        case (false, true, false, false):
            position.y += range
        case (false, false, true, false):
            position.x -= range
        case (false, false, false, true):
            position.y -= range

        case (true, true, false, false):
            position.x += range
            position.y += range
        case (false, true, true, false):
            position.x -= range
            position.y += range
        case (true, false, false, true):
            position.x += range
            position.y -= range
        case (false, false, true, true):
            position.x -= range
            position.y -= range
        case (false, false, false, false):
            print("colpo ???")
        default:
            break
        }
        meleeAttack.position = position

        self.spriteComponent.node.addChild(meleeAttack)
        let wait = SKAction.wait(forDuration: 0.5)
        let remove = SKAction.removeFromParent()
        meleeAttack.run(SKAction.sequence([wait, remove]))

    }
}
