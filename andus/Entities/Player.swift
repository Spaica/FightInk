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

    func setupAnimations() {
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

    override init() {
        super.init()
        self.spriteComponent.node.physicsBody = .init(
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

        self.spriteComponent.node.setScale(0.08)
        self.spriteComponent.node.zPosition = 2
        self.spriteComponent.node.name = "player"

        setupAnimations()
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

        var position = CGPoint.zero
        let range: CGFloat = 800
        let melee = Melee()
        let meleeAttack = melee.spriteComponent.node

        switch self.lastDirection {
        case 1:
            position.y += range
            meleeAttack.zRotation = CGFloat.pi / 2
        case 2:
            position.x -= range
            meleeAttack.zRotation = CGFloat.pi
            meleeAttack.yScale = -abs(meleeAttack.xScale)
        case 3:
            position.y -= range
            meleeAttack.zRotation = -CGFloat.pi / 2
            meleeAttack.yScale = -abs(meleeAttack.xScale)
        case 4:
            position.x += range
        case 5:
            position.x -= range
            position.y += range
            meleeAttack.zRotation = (CGFloat.pi * 3) / 4
            meleeAttack.yScale = -abs(meleeAttack.xScale)
        case 6:
            position.x -= range
            position.y -= range
            meleeAttack.zRotation = (CGFloat.pi * 5) / 4
            meleeAttack.yScale = -abs(meleeAttack.xScale)
        case 7:
            position.x += range
            position.y += range
            meleeAttack.zRotation = CGFloat.pi / 4
        case 8:
            position.x += range
            position.y -= range
            meleeAttack.zRotation = -CGFloat.pi / 4
        default:
            break
        }
        meleeAttack.position = position
        meleeAttack.zPosition = -0.1

        if let texture = meleeAttack.texture {
            meleeAttack.physicsBody = SKPhysicsBody(rectangleOf: texture.size())
            meleeAttack.physicsBody?.isDynamic = false
            meleeAttack.physicsBody?.categoryBitMask = CollisionBitMasks.melee
            meleeAttack.physicsBody?.contactTestBitMask =
                CollisionBitMasks.monster
            meleeAttack.physicsBody?.collisionBitMask = 0
        }

        self.spriteComponent.node.addChild(meleeAttack)
        let wait = SKAction.wait(forDuration: 0.2)
        let remove = SKAction.removeFromParent()
        meleeAttack.run(SKAction.sequence([wait, remove]))
    }
}
