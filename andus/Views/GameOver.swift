//
//  GameOver.swift
//  andus
//
//  Created by Andreina Costagliola on 08/04/26.
//

import SwiftUI

struct GameOver: View {
    @Binding var shouldStartGame: Bool
    let titleFontSize = 370.0

    var body: some View {
        Image(.startScreenBG)
            .resizable()
            .scaledToFill()
        VStack {
            Spacer()
            HStack {
                ZStack {
                    CoreTextLabel(
                        text: "Game Over",
                        fontName: "Sentreno",
                        fontSize: titleFontSize,
                        strokeColor: .darkRed,
                        fillColor: .clear,
                        strokeWidth: 7.0
                    )
                    CoreTextLabel(
                        text: "Game Over",
                        fontName: "Sentreno",
                        fontSize: titleFontSize,
                        strokeColor: .clear,
                        fillColor: .white,
                        strokeWidth: 0.0
                    )
                }.fixedSize()
            }
            Spacer()
            Button {
                self.shouldStartGame = true
            } label: {
                Text("Play again")
                    .foregroundStyle(.black)
                    .font(
                        .custom(
                            "Silom",
                            size: 40,
                            relativeTo: .title
                        )
                    )
            }.buttonStyle(.plain)
            Spacer()
        }
    }
}
