//
//  SpriteComponent.swift
//  andus
//
//  Created by Andreina Costagliola on 30/03/26.
//

import GameplayKit
import SpriteKit

class SpriteComponent: GKComponent {
    let node: SKSpriteNode

    init(texture: SKTexture) {
        node = SKSpriteNode(
            texture: texture,
            color: .white,
            size: texture.size()
        )
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
