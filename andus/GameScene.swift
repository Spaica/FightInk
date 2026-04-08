//
//  GameScene.swift
//  andus
//
//  Created by Adriano Oliviero on 27/03/26.
//

import Foundation
import GameplayKit
import SpriteKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    var shouldStartGame: Binding<Bool>?
    var isGameOver: Binding<Bool>?
    var entityManager: EntityManager!
    var monsters: [Monster] = []
    var playerEntity: Player?
    var background: Background?
    var worldBorder: WorldBorder?
    let cameraNode = SKCameraNode()
    var hordeIdx = 10

    private var lastUpdateTime: TimeInterval = 0

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }

    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
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
        let spawnWait = SKAction.wait(forDuration: 8)
        let spawn = SKAction.run {
            self.spawnMonsters()
        }
        let sequence = SKAction.sequence([spawnWait, spawn])
        self.run(SKAction.repeatForever(sequence))
    }

    func spawnMonsters() {
        guard let playerEntity = playerEntity else { return }
        guard let cameraSize = cameraNode.scene?.size else { return }
        var hordeCenter = CGPoint(
            x: playerEntity.spriteComponent.node.position.x
                + CGFloat.random(
                    in: cameraSize.width...(cameraSize.width + 300)
                ),
            y: playerEntity.spriteComponent.node.position.y
                + CGFloat.random(
                    in: cameraSize.height...(cameraSize.height + 300)
                )
        )
        hordeCenter.x *= CGFloat(Int.random(in: -1...1))
        hordeCenter.y *= CGFloat(Int.random(in: -1...1))
        for _ in 0..<hordeIdx {
            let monster = Monster(at: hordeCenter, range: 100.0)
            monsters.append(monster)
            self.entityManager.add(monster)
        }
        hordeIdx += 1
    }

    func didBegin(_ contact: SKPhysicsContact) {
        var monsterBody: SKPhysicsBody
        var meleeBody: SKPhysicsBody
        var playerBody: SKPhysicsBody
        var monsterMeleeBody: SKPhysicsBody

        //Player vs mostro
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            monsterBody = contact.bodyA
            meleeBody = contact.bodyB
        } else {
            monsterBody = contact.bodyB
            meleeBody = contact.bodyA
        }

        if (monsterBody.categoryBitMask & CollisionBitMasks.monster != 0)
            && (meleeBody.categoryBitMask & CollisionBitMasks.melee != 0)
        {
            if let monsterEntity = monsters.first(where: {
                $0.spriteComponent.node == monsterBody.node
            }) {

                if let damage = playerEntity?.attackValue {
                    monsterEntity.life -= damage
                }

                if monsterEntity.life <= 0 {
                    entityManager.remove(monsterEntity)
                    if let index = monsters.firstIndex(of: monsterEntity) {
                        monsters.remove(at: index)
                    }
                    monsterEntity.spriteComponent.node.removeFromParent()

                }
            }
        }

        //Mostro vs player
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            playerBody = contact.bodyA
            monsterMeleeBody = contact.bodyB
        } else {
            playerBody = contact.bodyB
            monsterMeleeBody = contact.bodyA
        }

        if (playerBody.categoryBitMask & CollisionBitMasks.player != 0)
            && (monsterMeleeBody.categoryBitMask & CollisionBitMasks.melee != 0)
        {
            if let attackNodeName = monsterMeleeBody.node?.name,
                let attackingMonster = monsters.first(where: {
                    "monsterMelee_\($0.spriteComponent.node.hash)"
                        == attackNodeName
                })
            {
                let damage = attackingMonster.attackValue
                playerEntity?.life -= damage

                if let life = playerEntity?.life, life <= 0 {
                    DispatchQueue.main.async {
                        self.isGameOver?.wrappedValue = true
                        self.shouldStartGame?.wrappedValue = false
                    }
                }
            }
        }

    }

    override func update(_ currentTime: TimeInterval) {
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }

        for entity in self.entityManager.entities {
            entity.update(deltaTime: currentTime - self.lastUpdateTime)
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
