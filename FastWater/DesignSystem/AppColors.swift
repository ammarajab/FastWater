//
//  AppColors.swift
//  FastWater
//
//  Created by Ammar on 16/08/2025.
//

import SwiftUI

struct AppColors {
    private static let white = Color(hex: "#FFFFFF")
    private static let gold = Color(hex: "#F0C17E")
    private static let lightGray = Color(hex: "#E9E9EB")
    private static let gray = Color(hex: "#C9C9C9")
    private static let silver = Color(hex: "#B8B8B8")
    private static let darkGray  = Color(hex: "#585858")
    private static let red = Color(hex: "#F96758")
    private static let orange = Color(hex: "#FF9500")
    private static let navy = Color(hex: "#081325")
    private static let slate = Color(hex: "#1B232F")
    private static let steel = Color(hex: "#20293A")
    private static let indigo = Color(hex: "#1E2C4B")
    private static let midnight = Color(hex: "#121F33")

    static let textPrimary = white
    static let textInverse = navy
    static let textAccent = gold
    static let textCritical = red
    static let textMuted = gray
    static let backgroundPrimary = navy
    static let backgroundInverse = white
    static let backgroundSecondary = midnight
    static let backgroundTertiary = steel
    static let backgroundMuted = slate
    static let backgroundCritical = red
    static let backgroundSeparator = silver
    static let buttonPrimary = red
    static let buttonSecondary = indigo
    static let shapeCritical = red
    static let shapeMuted = darkGray
    static let shapePrimary = navy
    static let shapeMain = white
    static let shapeActive = orange
    static let shapeInactive = lightGray
}
