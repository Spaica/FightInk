//
//  Monster.swift
//  andus
//
//  Created by Adriano Oliviero on 01/04/26.
//

import GameKit

class Monster: GKEntity {
    let spriteComponent = SpriteComponent(
        texture: SKTexture(imageNamed: "monster_1"),
    )
    var shouldMove: Bool = false
    var moveTarget: CGPoint = .zero
    var speed: CGFloat = 500
    private var spriteScale = 0.05
    var life: Float = 75
    var attackValue: Float = 10
    var hasAttacked: Bool = false
    var attackTimer: TimeInterval = 0

    init(at: CGPoint, range: CGFloat) {
        super.init()

        let offset = CGPoint(
            x: .random(in: -range...range),
            y: .random(in: -range...range)
        )

        spriteComponent.node.position = at + offset

        self.attackTimer = Double.random(in: 0...3.0)

        spriteComponent.node.setScale(spriteScale)
        spriteComponent.node.physicsBody = .init(
            circleOfRadius: min(
                spriteComponent.node.size.width,
                spriteComponent.node.size.height
            ) * 0.5
        )
        guard let body = spriteComponent.node.physicsBody else { return }
        body.isDynamic = true
        body.affectedByGravity = false
        body.allowsRotation = false
        body.node?.zPosition = 1
        body.linearDamping = 5
        body.categoryBitMask = CollisionBitMasks.monster
        body.collisionBitMask =
            CollisionBitMasks.worldBorder | CollisionBitMasks.player
            | CollisionBitMasks.monster

        addComponent(spriteComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func move() {
        let sprite = self.spriteComponent.node
        self.moveTarget =
            sprite.parent!.children.filter(
                { $0.name == "player" }
            ).first?.position ?? .zero
        let dis = (
            x: moveTarget.x - sprite.position.x,
            y: moveTarget.y - sprite.position.y
        )
        if hypot(dis.x, dis.y) > max(sprite.size.width, sprite.size.height)
            * 1.5
        {
            let angle = atan2(dis.y, dis.x)
            if let body = sprite.physicsBody {
                body.velocity = .init(
                    dx: cos(angle) * speed,
                    dy: sin(angle) * speed
                )
            }
        } else {
            shouldMove = false
        }
    }

    func attack() {
        guard !hasAttacked else { return }
        hasAttacked = true

        let range: CGFloat = 50
        let melee = MeleeMonster()
        let meleeAttack = melee.spriteComponent.node
        meleeAttack.name = "monsterMelee_\(self.spriteComponent.node.hash)"
        meleeAttack.setScale(0.06)

        guard let scene = self.spriteComponent.node.parent,
            let playerEntity = scene.childNode(withName: "player")
        else {
            hasAttacked = false
            return
        }

        let position = self.spriteComponent.node.position
        let dx = playerEntity.position.x - position.x
        let dy = playerEntity.position.y - position.y
        let angle = atan2(dy, dx)
        meleeAttack.position = CGPoint(
            x: position.x + cos(angle) * range,
            y: position.y + sin(angle) * range
        )
        meleeAttack.zRotation = angle
        meleeAttack.zPosition = -0.1

        if let texture = meleeAttack.texture {
            meleeAttack.physicsBody = SKPhysicsBody(rectangleOf: texture.size())
            meleeAttack.physicsBody?.isDynamic = false
            meleeAttack.physicsBody?.categoryBitMask = CollisionBitMasks.melee
            meleeAttack.physicsBody?.contactTestBitMask =
                CollisionBitMasks.player
            meleeAttack.physicsBody?.collisionBitMask = 0
        }

        scene.addChild(meleeAttack)
        let wait = SKAction.wait(forDuration: 0.2)
        let remove = SKAction.removeFromParent()
        meleeAttack.run(SKAction.sequence([wait, remove]))
        hasAttacked = false
    }

    override func update(deltaTime seconds: TimeInterval) {
        guard let parentNode = self.spriteComponent.node.parent,
            let playerNode = parentNode.childNode(withName: "player")
        else {
            return
        }
        if playerNode.position.x - self.spriteComponent.node.position.x < 0 {
            self.spriteComponent.node.xScale = -spriteScale
        } else {
            self.spriteComponent.node.xScale = spriteScale
        }

        //        if (self.spriteComponent.node.parent?.childNode(withName: "player")?
        //            .position.x)! - self.spriteComponent.node.position.x < 0
        //        {

        attackTimer += seconds
        if attackTimer >= 3.0 {
            attack()
            attackTimer = 0
        }

        move()
        //        }
    }
}
