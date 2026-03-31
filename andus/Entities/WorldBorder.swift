//
//  WorldBorder.swift
//  andus
//
//  Created by Adriano Oliviero on 31/03/26.
//

import GameKit

class WorldBorderNode: SKShapeNode {
    let radius = 800.0

    override init() {
        super.init()
        let worldBorderPath: CGPath = CGPath(
            ellipseIn: CGRect(
                x: -radius,
                y: -radius,
                width: radius * 2,
                height: radius * 2
            ),
            transform: nil
        )
        self.path = worldBorderPath
        self.physicsBody = SKPhysicsBody(
            edgeLoopFrom: worldBorderPath
        )
        self.position = .zero
        self.lineWidth = 16.0
        self.strokeColor = .red
        if let body = self.physicsBody {
            body.isDynamic = false
            body.friction = 0
            body.restitution = 0

        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
