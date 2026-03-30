//
//  ViewController.swift
//  andus
//
//  Created by Adriano Oliviero on 27/03/26.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GKScene(fileNamed: "GameScene") {
                if let sceneNode = scene.rootNode as? GameScene {
                    
                    sceneNode.scaleMode = .aspectFill
                    
                    if let view = self.skView {
                        view.presentScene(sceneNode)
                        view.ignoresSiblingOrder = true
                        view.showsFPS = true
                        view.showsNodeCount = true
                }
            }
        }
    }
}

