//
//  Background.swift
//  andus
//
//  Created by Adriano Oliviero on 30/03/26.
//

import GameKit
import SpriteKit

class Background: GKEntity {
    var cameraNode: SKCameraNode?
    var entityManager: EntityManager?
    var tileAmount: (x: Int, y: Int)?
    var tileEntities: [BGTile] = []
    var displaySize: CGSize?

    init(cameraNode: SKCameraNode?, entityManager: EntityManager?) {
        super.init()
        self.cameraNode = cameraNode
        self.entityManager = entityManager

        self.displaySize = self.cameraNode?.frame.size ?? .zero
        guard let displaySize = self.displaySize else { return }
        // loading the texture to calculate the amount of tiles needed
        let tileSize = BGTile(x: 0, y: 0).spriteComponent.node.frame.size
        self.tileAmount = (
            x: Int(displaySize.width / tileSize.width) + 1,
            y: Int(displaySize.height / tileSize.height) + 1
        )
        guard let tileAmount = self.tileAmount else { return }

        // actually generating the tiles
        for i in 0..<tileAmount.x {
            for j in 0..<tileAmount.y {
                self.tileEntities.append(
                    BGTile(
                        x: (CGFloat(i) * tileSize.width),
                        y: (CGFloat(j) * tileSize.height)
                    )
                )
                self.entityManager?.add(self.tileEntities.last!)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        guard let cam = self.cameraNode else { return }
        guard let displaySize = self.displaySize else { return }
        // moving the ground tiles
        for t in self.tileEntities {
            let node = t.spriteComponent.node
            let cameraTileDist = (
                x: abs(node.position.x - cam.position.x),
                y: abs(node.position.y - cam.position.y)
            )
            let maxCTDist = (
                x: node.size.width + displaySize.width,
                y: node.size.height + displaySize.height
            )
            if cameraTileDist.x > maxCTDist.x {
                t.spriteComponent.node.position.x = 0
            }
        }
    }
}
