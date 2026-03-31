//
//  BGTile.swift
//  andus
//
//  Created by Adriano Oliviero on 30/03/26.
//

import GameplayKit

class BGTile: GKEntity {
    var spriteComponent = SpriteComponent(
        texture: SKTexture(imageNamed: "ground")
    )
    init(x: CGFloat, y: CGFloat) {
        super.init()
        self.spriteComponent.node.zRotation = CGFloat.pi / 2
        self.spriteComponent.node.zPosition = -0.1
        self.spriteComponent.node.setScale(0.2)
        self.spriteComponent.node.position = CGPoint(x: x, y: y)
        addComponent(self.spriteComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
