//
//  GameScene.swift
//  andus
//
//  Created by Adriano Oliviero on 27/03/26.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene {
    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()
    
    private var lastUpdateTime: TimeInterval = 0
    private var label: SKLabelNode?
    private var spinnyNode: SKShapeNode?
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = event.location(in: self)
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = event.location(in: self)
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = event.location(in: self)
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31:
            if let label = self.label {
                label.run(SKAction(named: "Pulse")!, withKey: "fadeInOut")
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
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
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
