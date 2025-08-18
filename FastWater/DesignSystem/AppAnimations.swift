//
//  AppAnimations.swift
//  FastWater
//
//  Created by Ammar on 16/08/2025.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.5),
                       value: configuration.isPressed)
    }
}
