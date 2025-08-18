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
    private static let gray = Color(hex: "#C9C9C9")
    private static let red = Color(hex: "#F96758")
    private static let navy = Color(hex: "#081325")
    private static let slate = Color(hex: "#1B232F")
    private static let indigo = Color(hex: "#1E2C4B")

    static let textPrimary = white
    static let textInverse = navy
    static let textAccent = gold
    static let textCritical = red
    static let textMuted = gray
    static let backgroundPrimary = navy
    static let backgroundSecondary = slate
    static let backgroundCritical = red
    static let buttonPrimary = red
    static let buttonSecondary = indigo
    static let shapeCritical = red
    static let shapeDivider = navy
}
