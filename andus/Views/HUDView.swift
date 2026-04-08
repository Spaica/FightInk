//
//  HUDView.swift
//  andus
//
//  Created by Adriano Oliviero on 08/04/2026.
//

import SwiftUI

@Observable
class HUDState {
    var playerHealth: Float = 100
}

struct HUDView: View {
    var hudState: HUDState

    var body: some View {
        VStack {
            HStack {
                Text("\(Int(hudState.playerHealth))")
                    .font(.custom("Silom", size: 30, relativeTo: .title))
                    .foregroundStyle(hudState.playerHealth > 25 ? .white : .red)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .padding()

                Spacer()
            }
            Spacer()
        }.ignoresSafeArea()
    }
}
