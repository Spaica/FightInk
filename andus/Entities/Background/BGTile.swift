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

        //        let border = SKShapeNode(rectOf: self.spriteComponent.node.size)
        //        border.strokeColor = .red
        //        border.lineWidth = 10
        //        border.alpha = 1
        //        self.spriteComponent.node.addChild(border)

        self.spriteComponent.node.zPosition = -0.1
        self.spriteComponent.node.position = CGPoint(x: x, y: y)
        self.spriteComponent.node.alpha = 0.8
        addComponent(self.spriteComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
