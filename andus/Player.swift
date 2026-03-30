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
        texture: SKTexture(imageNamed: "player")
    )
    var moving: Bool = false
    var direction: Int = 0

    init(imageName: String) {
        super.init()
        self.spriteComponent.node.zRotation = CGFloat.pi / 2
        addComponent(self.spriteComponent)

    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        move(deltaTime: seconds)
    }

    func move(deltaTime seconds: TimeInterval) {
        let speed: CGFloat = 3000 * seconds
        if moving == true {
            if let body = self.spriteComponent.node.physicsBody {
                body.velocity.dx +=
                    direction == 4 ? speed : direction == 2 ? -speed : 0
                body.velocity.dy +=
                    direction == 1 ? speed : direction == 3 ? -speed : 0
            }
        }
    }
}
