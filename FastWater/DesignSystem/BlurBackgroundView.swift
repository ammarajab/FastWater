//
//  BlurBackgroundView.swift
//  FastWater
//
//  Created by Ammar on 23/08/2025.
//

import SwiftUI

struct BlurBackgroundView: View {
    var body: some View {
        ZStack {
            AppColors.backgroundPrimary.opacity(0.3).ignoresSafeArea()
            VisualEffectBlur()
                .ignoresSafeArea()
        }
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style = .systemUltraThinMaterialDark

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
