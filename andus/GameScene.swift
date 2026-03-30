//
//  GameScene.swift
//  andus
//
//  Created by Adriano Oliviero on 27/03/26.
//

import Foundation
import GameplayKit
import SpriteKit

class GameScene: SKScene {
    var entityManager: EntityManager!
    var playerEntity: Player?
    var spriteComponent: SpriteComponent?

    private var lastUpdateTime: TimeInterval = 0

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }

    override func didMove(to view: SKView) {
        self.entityManager = EntityManager(scene: self)

        self.playerEntity = Player(imageName: "player")

        if let player = self.playerEntity {
            if let component = player.component(ofType: SpriteComponent.self) {
                self.spriteComponent = component
                self.spriteComponent?.node.position = CGPoint(
                    x: self.frame.midX,
                    y: self.frame.midY
                )
                self.spriteComponent?.node.zPosition = 10
            }

            backgroundColor = SKColor.darkGray

            self.entityManager.add(player)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }

        let dt = currentTime - self.lastUpdateTime

        for entity in self.entityManager.entities {
            entity.update(deltaTime: dt)
        }

        self.lastUpdateTime = currentTime
    }

    //    override func mouseDown(with event: NSEvent) {}
    //    override func mouseDragged(with event: NSEvent) {}
    //    override func mouseUp(with event: NSEvent) {}

    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x0d:
            self.playerEntity?.direction = 1
            self.playerEntity?.moving = true
        case 0x00:
            self.playerEntity?.direction = 2
            self.playerEntity?.moving = true
        case 0x01:
            self.playerEntity?.direction = 3
            self.playerEntity?.moving = true
        case 0x02:
            self.playerEntity?.direction = 4
            self.playerEntity?.moving = true
        default:
            break
        }
    }

    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 0x0d, 0x00, 0x01, 0x02:
            self.playerEntity?.moving = false
        default:
            break
        }
    }
}
