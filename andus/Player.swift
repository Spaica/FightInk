//
//  Player.swift
//  andus
//
//  Created by Andreina Costagliola on 30/03/26.
//

import Foundation
import SpriteKit
import GameplayKit

class Player: GKEntity {
    var position: CGPoint = CGPoint(x: 0, y: 0)

  init(imageName: String) {
    super.init()


    let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: "player"))
    addComponent(spriteComponent)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
    func move ()
    
    
    
}
