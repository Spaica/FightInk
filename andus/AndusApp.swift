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
    @State var shouldStartGame: Bool = false
    @State var isGameOver: Bool = false
    @FocusState private var isGameFocused: Bool

    var body: some Scene {
        WindowGroup {
            ZStack {
                if isGameOver {
                    GameOver(
                        shouldStartGame: Binding(
                            get: { self.shouldStartGame },
                            set: { newValue in
                                self.isGameOver = false
                                self.shouldStartGame = newValue
                            }
                        )
                    )
                } else if !self.shouldStartGame {
                    StartGameView(shouldStartGame: $shouldStartGame)
                } else {
                    GeometryReader { g in
                        SpriteView(
                            scene: {
                                let s = GameScene()
                                s.size = g.size
                                s.scaleMode = .resizeFill
                                s.shouldStartGame = $shouldStartGame
                                s.isGameOver = $isGameOver
                                return s
                            }(),
                            debugOptions: [
                                .showsFPS, .showsNodeCount,
                                .showsPhysics, .showsFields,
                            ]
                        )
                    }
                    .focusable()
                    .focused(self.$isGameFocused)
                    .onAppear {
                        self.isGameFocused = true
                    }
                }
            }
            .frame(minWidth: 400, minHeight: 400)
            .onAppear {
                DispatchQueue.main.async {
                    if let window = NSApplication.shared.windows.first {
                        window.toggleFullScreen(nil)
                    }
                }
            }
        }
    }
}
