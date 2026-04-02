//
//  CollisionField.swift
//  andus
//
//  Created by Adriano Oliviero on 02/04/26.
//

import GameplayKit
import SpriteKit

class CollisionField: SKNode {
    let field = SKFieldNode.springField()
    private var _size: CGSize = .init(width: 1000, height: 1000)
    var size: CGSize {
        get { return field.region?.path?.boundingBox.size ?? .zero }
        set(newSize) {
            _size = newSize
            self.field.region = .init(
                path: CGPath(
                    rect: CGRect(
                        x: self.field.position.x - _size.width,
                        y: self.field.position.y - _size.height,
                        width: _size.width * 2,
                        height: _size.height * 2
                    ),
                    transform: nil
                )
            )
        }
    }

    init(size: CGSize = .init(width: 1000, height: 1000)) {
        super.init()
        self.field.falloff = -2.0
        self.field.strength = -500.0
        self.field.categoryBitMask = CollisionBitMasks.enemy
        self.size = size
        self.addChild(self.field)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
