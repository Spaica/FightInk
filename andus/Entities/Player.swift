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
        texture: SKTexture(imageNamed: "player1")
    )
    var fieldNode = CollisionField()
    var moving = (w: false, a: false, s: false, d: false)
    var hasAttacked: Bool = true
    var lastDirection: Int = 0

    private var playerAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Player")
    }

    private var playerTextures: [SKTexture] {
        return [
            playerAtlas.textureNamed("player1"),
            playerAtlas.textureNamed("player2"),
        ]
    }

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

        self.spriteComponent.node.setScale(0.1)
        self.spriteComponent.node.zPosition = 2

        self.fieldNode.size = self.spriteComponent.node.size
        self.spriteComponent.node.physicsBody?.node?.addChild(self.fieldNode)

        addComponent(self.spriteComponent)
    }

    required init?(coder: NSCoder) {
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
            let speed: CGFloat = 10000

            if moving.w || moving.a || moving.s || moving.d {
                if self.spriteComponent.node.action(forKey: "walk")
                    == nil
                {
                    let walkAnimation = SKAction.animate(
                        with: playerTextures,
                        timePerFrame: 0.3
                    )
                    let repeatWalk = SKAction.repeatForever(walkAnimation)
                    self.spriteComponent.node.run(
                        repeatWalk,
                        withKey: "walk"
                    )
                }
            } else {
                self.spriteComponent.node.removeAction(forKey: "walk")
                self.spriteComponent.node.texture = playerTextures[0]
            }

            if moving.w && moving.a {
                self.lastDirection = 5
            } else if moving.w && moving.d {
                self.lastDirection = 7
            } else if moving.s && moving.a {
                self.lastDirection = 6
            } else if moving.s && moving.d {
                self.lastDirection = 8
            } else if moving.w {
                self.lastDirection = 1
            } else if moving.a {
                self.lastDirection = 2
            } else if moving.s {
                self.lastDirection = 3
            } else if moving.d {
                self.lastDirection = 4
            }

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
        let range: CGFloat = 1000
        let melee = Melee()
        let meleeAttack = melee.spriteComponent.node

        switch self.lastDirection {
        case 1:
            position.y += range
        case 2:
            position.x -= range
        case 3:
            position.y -= range
        case 4:
            position.x += range
        case 5:
            position.x -= range
            position.y += range
        case 6:
            position.x -= range
            position.y -= range
        case 7:
            position.x += range
            position.y += range
        case 8:
            position.x += range
            position.y -= range
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
