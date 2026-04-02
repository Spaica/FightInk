//
//  AndusApp.swift
//  andus
//
//  Created by Adriano Oliviero on 30/03/26.
//

import SpriteKit
import SwiftUI

@main
struct AndusApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                GeometryReader { g in
                    SpriteView(
                        scene: {
                            let s = GameScene()
                            s.size = g.size
                            s.scaleMode = .resizeFill
                            return s
                        }(),
                        debugOptions: [
                            .showsFPS, .showsNodeCount,
                            .showsPhysics, .showsFields,
                        ]
                    )
                }
                //                VStack {
                //                    Button {
                //                        print("Hello, World!")
                //                    } label: {
                //                        Text("Hello, World!")
                //                    }.buttonStyle(.glassProminent)
                //                }
            }
        }
    }
}
