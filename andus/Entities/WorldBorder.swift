//
//  WorldBorder.swift
//  andus
//
//  Created by Adriano Oliviero on 31/03/26.
//

import GameKit

class WorldBorderNode: SKShapeNode {
    let radius = 16000.0

    override init() {
        super.init()

        self.path = CGPath(
            ellipseIn: CGRect(
                x: -radius,
                y: -radius,
                width: (radius * 2) + 32,
                height: (radius * 2) + 32
            ),
            transform: nil
        )
        self.physicsBody = SKPhysicsBody(
            edgeLoopFrom: CGPath(
                ellipseIn: CGRect(
                    x: -radius,
                    y: -radius,
                    width: radius * 2,
                    height: radius * 2
                ),
                transform: nil
            )
        )
        self.position = .zero
        self.zPosition = -0.1
        self.lineWidth = 64.0
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
