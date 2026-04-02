//
//  WorldBorder.swift
//  andus
//
//  Created by Adriano Oliviero on 31/03/26.
//

import GameKit

class WorldBorder: SKShapeNode {
    let radius = 800.0

    override init() {
        super.init()
        let path: CGPath = CGPath(
            rect: CGRect(
                x: -radius,
                y: -radius,
                width: radius * 2,
                height: radius * 2
            ),
            transform: nil
        )
        self.path = path
        self.position = .zero
        self.lineWidth = 16.0
        self.strokeColor = .red
        self.physicsBody = SKPhysicsBody(
            edgeLoopFrom: path
        )
        guard let body = self.physicsBody else { return }
        body.isDynamic = false
        body.friction = 0
        body.restitution = 0
        body.categoryBitMask = CollisionBitMasks.worldBorder
        body.fieldBitMask = 0b0

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
