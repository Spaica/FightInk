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
        texture: SKTexture(imageNamed: "player_idle_1")
    )
    var moving = (w: false, a: false, s: false, d: false)
    var hasAttacked: Bool = true
    var lastDirection: Int = 0
    var life: Float = 100
    var attackValue: Float = 25
    var defense: Float = 10

    private var walkAnimation: SKAction?
    private var idleAnimation: SKAction?

    func initAnimations() {
        let playerAtlas: SKTextureAtlas = SKTextureAtlas(named: "Player")
        let walkTextures: [SKTexture] = [
            playerAtlas.textureNamed("player_walk_1"),
            playerAtlas.textureNamed("player_walk_2"),
            playerAtlas.textureNamed("player_walk_3"),
            playerAtlas.textureNamed("player_walk_4"),
        ]
        let idleTextures: [SKTexture] = [
            playerAtlas.textureNamed("player_idle_1"),
            playerAtlas.textureNamed("player_idle_2"),
        ]
        self.walkAnimation = SKAction.animate(
            with: walkTextures,
            timePerFrame: 0.15
        )
        self.idleAnimation = SKAction.animate(
            with: idleTextures,
            timePerFrame: 0.35
        )
    }

    func initBody() {
        self.spriteComponent.node.physicsBody = SKPhysicsBody(
            polygonFrom: CGPath(
                ellipseIn: self.spriteComponent.node.frame,
                transform: nil
            )
        )
        guard let body = self.spriteComponent.node.physicsBody else { return }
        body.affectedByGravity = false
        body.linearDamping = 10
        body.mass = 80
        body.allowsRotation = false
        body.categoryBitMask = CollisionBitMasks.player
        body.collisionBitMask = CollisionBitMasks.worldBorder
    }

    override init() {
        super.init()

        self.spriteComponent.node.setScale(0.08)
        self.spriteComponent.node.zPosition = 2
        self.spriteComponent.node.name = "player"

        initBody()

        initAnimations()
        self.spriteComponent.node.run(
            SKAction.repeatForever(self.idleAnimation!)
        )

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
                    self.spriteComponent.node.run(
                        SKAction.repeatForever(walkAnimation!),
                        withKey: "walk"
                    )
                }
            } else {
                self.spriteComponent.node.removeAction(forKey: "walk")
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

            var inputVelocity =
                CGVector(
                    dx: (moving.d ? speed : 0)
                        + (moving.a ? -speed : 0),
                    dy: (moving.w ? speed : 0)
                        + (moving.s ? -speed : 0)
                ) * seconds

            if inputVelocity.dx != 0 && inputVelocity.dy != 0 {
                inputVelocity *= 0.7071067812
            }
            body.velocity += inputVelocity
        }
    }

    func attack() {
        guard !hasAttacked else { return }
        hasAttacked = true

        let range: CGFloat = 800
        let melee = Melee(
            imageNamed: "melee_player",
            contactTestBitMask: CollisionBitMasks.monster
        )
        guard let meleeNode = melee.spriteComponent?.node else { return }

        switch self.lastDirection {
        case 1:
            meleeNode.position.y += range
            meleeNode.zRotation = CGFloat.pi / 2
        case 2:
            meleeNode.position.x -= range
            meleeNode.zRotation = CGFloat.pi
            meleeNode.yScale = -abs(meleeNode.xScale)
        case 3:
            meleeNode.position.y -= range
            meleeNode.zRotation = -CGFloat.pi / 2
            meleeNode.yScale = -abs(meleeNode.xScale)
        case 4:
            meleeNode.position.x += range
        case 5:
            meleeNode.position.x -= range
            meleeNode.position.y += range
            meleeNode.zRotation = (CGFloat.pi * 3) / 4
            meleeNode.yScale = -abs(meleeNode.xScale)
        case 6:
            meleeNode.position.x -= range
            meleeNode.position.y -= range
            meleeNode.zRotation = (CGFloat.pi * 5) / 4
            meleeNode.yScale = -abs(meleeNode.xScale)
        case 7:
            meleeNode.position.x += range
            meleeNode.position.y += range
            meleeNode.zRotation = CGFloat.pi / 4
        case 8:
            meleeNode.position.x += range
            meleeNode.position.y -= range
            meleeNode.zRotation = -CGFloat.pi / 4
        default:
            break
        }

        self.spriteComponent.node.addChild(meleeNode)
        let wait = SKAction.wait(forDuration: 0.2)
        let remove = SKAction.removeFromParent()
        meleeNode.run(
            SKAction.sequence([
                wait, SKAction.fadeOut(withDuration: 0.1), remove,
            ])
        )
    }
}
