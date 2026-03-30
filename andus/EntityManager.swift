//
//  EntityManager.swift
//  andus
//
//  Created by Andreina Costagliola on 30/03/26.
//

import Foundation
import GameplayKit
import SpriteKit

class EntityManager {
    var entities = Set<GKEntity>()
    let scene: SKScene

    init(scene: SKScene) {
        self.scene = scene
    }

    func add(_ entity: GKEntity) {
        entities.insert(entity)

        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node
        {
            scene.addChild(spriteNode)
        }
    }

    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node
        {
            spriteNode.removeFromParent()
        }

        entities.remove(entity)
    }
}
