//
//  Int.swift
//  FastWater
//
//  Created by Ammar on 17/08/2025.
//

import SwiftUI

extension Int {
    func deviceScaled() -> Double {
        let width = UIScreen.main.bounds.width
        if width < 380 {
            return Double(self) * 0.7
        }
        if width < 395 {
            return Double(self) * 0.8
        }
        if width < 415 {
            return Double(self) * 0.9
        }
        return Double(self)
    }
}
