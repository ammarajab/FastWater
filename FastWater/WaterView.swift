//
//  WaterView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct WaterView: View {
    var body: some View {
        ZStack {
            Color(hex: "081325")
                .ignoresSafeArea()
            Text("Water View")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    WaterView()
}
