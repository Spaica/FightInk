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
                Text("Game")
                    .foregroundStyle(.titleFont)
                    .font(
                        .custom(
                            "Sentreno",
                            size: titleFontSize,
                            relativeTo: .title
                        )
                    )
                ZStack {
                    CoreTextLabel(
                        text: "Over",
                        fontName: "Sentreno",
                        fontSize: titleFontSize,
                        strokeColor: .titleFont,
                        fillColor: .clear,
                        strokeWidth: 7.0
                    )
                    CoreTextLabel(
                        text: "Over",
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
                    .foregroundStyle(.titleFont)
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
