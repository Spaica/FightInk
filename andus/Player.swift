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
    var spriteComponent: SpriteComponent?
    var moving: Bool = false
    var direction: Int = 0

    init(imageName: String) {
        super.init()

        let component = SpriteComponent(
            texture: SKTexture(imageNamed: "player")
        )
        self.spriteComponent = component

        addComponent(spriteComponent!)
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
                let currentPosition = spriteComponent?.node.position
                spriteComponent?.node.position = CGPoint(
                    x: currentPosition!.x,
                    y: currentPosition!.y + 5
                )
            case 2:
                let currentPosition = spriteComponent?.node.position
                spriteComponent?.node.position = CGPoint(
                    x: currentPosition!.x - 5,
                    y: currentPosition!.y
                )
            case 3:
                let currentPosition = spriteComponent?.node.position
                spriteComponent?.node.position = CGPoint(
                    x: currentPosition!.x,
                    y: currentPosition!.y - 5
                )
            case 4:
                let currentPosition = spriteComponent?.node.position
                spriteComponent?.node.position = CGPoint(
                    x: currentPosition!.x + 5,
                    y: currentPosition!.y
                )
            default:
                break
            }
        }
    }
}
