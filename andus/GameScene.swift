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
        entityManager = EntityManager(scene: self)

        let player = Player(imageName: "player")
        self.playerEntity = player
        
        if let component = player.component(ofType: SpriteComponent.self) {
            self.spriteComponent = component
            spriteComponent?.node.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                    spriteComponent?.node.zPosition = 10
        }
        
        backgroundColor = SKColor.blue
        
        entityManager.add(player)

    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in entityManager.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
//    override func mouseDown(with event: NSEvent) {
//        
//    }
//    
//    override func mouseDragged(with event: NSEvent) {
//        
//    }
//    
//    override func mouseUp(with event: NSEvent) {
//        
//    }
//    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0xD:
            let currentPosition = spriteComponent?.node.position
            spriteComponent?.node.position = CGPoint(x: currentPosition!.x, y: currentPosition!.y + 5)
        default:
            print ("ciao")
            
        }
    
    }
    
}

// 0x0 0x1 0x2
