//
//  HomeView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(hex: "081325")
                .ignoresSafeArea()
            Text("Home View")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    HomeView()
}
