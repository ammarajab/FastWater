//
//  AppFonts.swift
//  FastWater
//
//  Created by Ammar on 15/08/2025.
//

import SwiftUI

struct AppFonts {
    static func title(size: CGFloat, scale: Bool) -> Font {
        if scale {
            Font.custom("Lato-BlackItalic", size: scaled(size))
        } else {
            Font.custom("Lato-BlackItalic", size: size)
        }
    }

    static func title2(size: CGFloat, scale: Bool) -> Font {
        if scale {
            Font.custom("Lato-Black", size: scaled(size))
        } else {
            Font.custom("Lato-Black", size: size)
        }
    }

    static func body(size: CGFloat, scale: Bool) -> Font {
        if scale {
            Font.custom("Lato-Regular", size: scaled(size))
        } else {
            Font.custom("Lato-Regular", size: size)
        }
    }

    private static func scaled(_ baseSize: CGFloat) -> CGFloat {
        Int(baseSize).deviceScaled()
    }
}

extension Text {
    func title(size: CGFloat = 32,
               color: Color = AppColors.textPrimary,
               letterSpacing: CGFloat = 0,
               scale: Bool = true) -> Text {
        self
            .font(AppFonts.title(size: size, scale: scale))
            .foregroundColor(color)
            .kerning(letterSpacing)
    }

    func title2(size: CGFloat = 24,
                color: Color = AppColors.textPrimary,
                letterSpacing: CGFloat = 0,
                scale: Bool = true) -> Text {
        self
            .font(AppFonts.title2(size: size, scale: scale))
            .foregroundColor(color)
            .kerning(letterSpacing)
    }
    
    func body(size: CGFloat = 16,
              color: Color = AppColors.textPrimary,
              letterSpacing: CGFloat = 0,
              scale: Bool = true) -> Text {
        self
            .font(AppFonts.body(size: size, scale: scale))
            .foregroundColor(color)
            .kerning(letterSpacing)
    }
}

