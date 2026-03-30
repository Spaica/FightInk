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

        //        self.spriteComponent =

        self.spriteComponent.node.zRotation = CGFloat.pi / 2
        addComponent(self.spriteComponent)

    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        move()
    }

    func move() {
        if moving == true {
            switch direction {
            case 1:
                spriteComponent.node.position.y += 5
            case 2:
                spriteComponent.node.position.x -= 5
            case 3:
                spriteComponent.node.position.y -= 5
            case 4:
                spriteComponent.node.position.x += 5
            default:
                break
            }
        }
    }
}
