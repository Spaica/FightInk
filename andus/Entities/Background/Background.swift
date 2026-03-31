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

        self.displaySize = self.cameraNode?.scene?.size ?? .zero
        guard let displaySize = self.displaySize else { return }
        // loading the texture to calculate the amount of tiles needed
        let tileSize = BGTile(x: 0, y: 0).spriteComponent.node.frame.size
        self.tileAmount = (
            x: Int(displaySize.width / tileSize.width) + 2,
            y: Int(displaySize.height / tileSize.height) + 2
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
            let tileNode = t.spriteComponent.node
            let cameraTileDist = (
                x: abs(tileNode.position.x - cam.position.x) * 1.7,
                y: abs(tileNode.position.y - cam.position.y) * 1.7
            )
            let maxCTDist = (
                x: tileNode.size.width + displaySize.width,
                y: tileNode.size.height + displaySize.height
            )
            if cameraTileDist.x > maxCTDist.x {
                if tileNode.position.x > cam.position.x {
                    tileNode.position.x +=
                        -(tileNode.size.width * CGFloat(tileAmount!.x))
                } else {
                    tileNode.position.x +=
                        (tileNode.size.width * CGFloat(tileAmount!.x))
                }
            }
            if cameraTileDist.y > maxCTDist.y {
                if tileNode.position.y > cam.position.y {
                    tileNode.position.y +=
                        -(tileNode.size.height * CGFloat(tileAmount!.y))
                } else {
                    tileNode.position.y +=
                        (tileNode.size.height * CGFloat(tileAmount!.y))
                }
            }
        }
    }
}
