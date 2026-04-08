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
    @State private var hudState = HUDState()

    var body: some Scene {
        WindowGroup {
            Group {
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
                    ZStack {
                        GeometryReader { g in
                            SpriteView(
                                scene: {
                                    let s = GameScene()
                                    s.size = g.size
                                    s.scaleMode = .resizeFill
                                    s.shouldStartGame = $shouldStartGame
                                    s.isGameOver = $isGameOver
                                    s.hudState = hudState
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
                        HUDView(hudState: hudState)
                    }
                }
            }.frame(minWidth: 400, minHeight: 400)
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
