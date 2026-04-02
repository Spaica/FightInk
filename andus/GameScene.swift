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
    var enemies: [GKEntity] = []
    var background: Background?
    var worldBorder: WorldBorder?
    let cameraNode = SKCameraNode()

    private var lastUpdateTime: TimeInterval = 0

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.darkGray
        self.entityManager = EntityManager(scene: self)

        self.worldBorder = WorldBorder()
        addChild(self.worldBorder!)

        self.camera = cameraNode
        addChild(cameraNode)
        self.background = Background(
            cameraNode: self.cameraNode,
            entityManager: self.entityManager
        )
        self.entityManager.add(self.background!)

        self.playerEntity = Player()
        guard let playerEntity else { return }
        if let component = playerEntity.component(ofType: SpriteComponent.self)
        {
            self.cameraNode.constraints = [
                SKConstraint.distance(
                    SKRange(constantValue: 0.0),
                    to: component.node
                )
            ]
        }
        self.entityManager.add(playerEntity)

        enemies.append(Enemy())
        //        if let lastEnemy = enemies.last {
        //            lastEnemy.
        //        }

        for enemy in enemies {
            self.entityManager.add(enemy)
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
        guard let playerEntity else { return }
        switch event.keyCode {
        case 0x0d:
            playerEntity.moving.w = true
        case 0x00:
            playerEntity.moving.a = true
        case 0x01:
            playerEntity.moving.s = true
        case 0x02:
            playerEntity.moving.d = true
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
        case 0x31:
            self.playerEntity?.hasAttacked = false
        default:
            break
        }
    }
}
