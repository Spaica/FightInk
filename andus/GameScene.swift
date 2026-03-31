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
    var background: Background?
    let cameraNode = SKCameraNode()

    private var lastUpdateTime: TimeInterval = 0

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.darkGray
        self.entityManager = EntityManager(scene: self)

        self.camera = cameraNode
        addChild(cameraNode)
        self.background = Background(
            cameraNode: self.cameraNode,
            entityManager: self.entityManager
        )
        self.entityManager.add(self.background!)

        self.playerEntity = Player()
        guard let player = self.playerEntity else { return }
        if let component = player.component(ofType: SpriteComponent.self) {
            self.cameraNode.constraints = [
                SKConstraint.distance(
                    SKRange(constantValue: 10.0),
                    to: component.node
                )
            ]
        }
        self.entityManager.add(player)
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
            self.playerEntity?.moving.w = true
        case 0x00:
            self.playerEntity?.moving.a = true
        case 0x01:
            self.playerEntity?.moving.s = true
        case 0x02:
            self.playerEntity?.moving.d = true
        default:
            break
        }
    }

    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 0x0d:
            self.playerEntity?.moving.w = false
        case 0x00:
            self.playerEntity?.moving.a = false
        case 0x01:
            self.playerEntity?.moving.s = false
        case 0x02:
            self.playerEntity?.moving.d = false
        default:
            break
        }
    }
}
