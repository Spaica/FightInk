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

    init(at: CGPoint, range: CGFloat) {
        super.init()
        let offset = CGPoint(
            x: .random(in: -range...range),
            y: .random(in: -range...range)
        )

        spriteComponent.node.position = at + offset
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

    override func update(deltaTime seconds: TimeInterval) {
        if (self.spriteComponent.node.parent?.childNode(withName: "player")?
            .position.x)! - self.spriteComponent.node.position.x < 0
        {
            self.spriteComponent.node.xScale = -spriteScale
        } else {
            self.spriteComponent.node.xScale = spriteScale
        }
        //        if shouldMove {
        move()
        //        }
    }
}
