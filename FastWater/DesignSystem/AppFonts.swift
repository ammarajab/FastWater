//
//  AppFonts.swift
//  FastWater
//
//  Created by Ammar on 15/08/2025.
//

import SwiftUI

struct AppColors {
    private static let white = Color(hex: "#FFFFFF")
    private static let gold = Color(hex: "#F0C17E")
    private static let gray = Color(hex: "#C9C9C9")
    private static let red = Color(hex: "#F96758")
    private static let navy = Color(hex: "#081325")

    static let textPrimary  = white
    static let textInverse  = navy
    static let textAccent   = gold
    static let textCritical = red
    static let textMuted    = gray
}

struct AppFonts {
    static func title(size: CGFloat) -> Font {
        Font.custom("Lato-BlackItalic", size: scaled(size))
    }

    static func title2(size: CGFloat) -> Font {
        Font.custom("Lato-Black", size: scaled(size))
    }

    static func body(size: CGFloat) -> Font {
        Font.custom("Lato-Regular", size: scaled(size))
    }

    private static func scaled(_ baseSize: CGFloat) -> CGFloat {
        let width = UIScreen.main.bounds.width
        if width < 380 {
            return baseSize * 0.9
        } else {
            return baseSize
        }
    }
}

extension Text {
    func title(size: CGFloat = 32,
               color: Color = AppColors.textPrimary,
               letterSpacing: CGFloat = 0) -> Text {
        self
            .font(AppFonts.title(size: size))
            .foregroundColor(color)
            .kerning(letterSpacing)
    }

    func title2(size: CGFloat = 24,
                  color: Color = AppColors.textPrimary,
                  letterSpacing: CGFloat = 0) -> Text {
        self
            .font(AppFonts.title2(size: size))
            .foregroundColor(color)
            .kerning(letterSpacing)
    }
    
    func body(size: CGFloat = 16,
                     color: Color = AppColors.textPrimary,
                     letterSpacing: CGFloat = 0) -> Text {
        self
            .font(AppFonts.body(size: size))
            .foregroundColor(color)
            .kerning(letterSpacing)
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.5),
                       value: configuration.isPressed)
    }
}
