//
//  StartGameView.swift
//  andus
//
//  Created by Adriano Oliviero on 07/04/2026.
//

import SwiftUI

struct StartGameView: View {
    @Binding var shouldStartGame: Bool
    let titleFontSize = 370.0
    var body: some View {
        Image(.startScreenBG)
            .resizable()
            .scaledToFill()
        VStack {
            Spacer()
            HStack {
                Text("Fight")
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
                        text: "ink",
                        fontName: "Sentreno",
                        fontSize: titleFontSize,
                        strokeColor: .titleFont,
                        fillColor: .clear,
                        strokeWidth: 7.0
                    )
                    CoreTextLabel(
                        text: "ink",
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
                Text("Play")
                    .foregroundStyle(.titleFont)
                    .font(
                        .custom(
                            "Silom",
                            size: 40,
                            relativeTo: .title
                        )
                    )
            }.buttonStyle(.plain)
            Button {
                print(
                    "do you even need options?\nlike for real, are you not happy with the defaults?"
                )
            } label: {
                Text("Options")
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
