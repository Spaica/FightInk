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
    var position: CGPoint = .init(x: 0, y: 0)

    init(imageName: String) {
        super.init()

        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: "player"))
        addComponent(spriteComponent)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func move() {}
}
