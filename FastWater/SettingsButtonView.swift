//
//  SettingsButtonView.swift
//  FastWater
//
//  Created by Ammar on 03/08/2025.
//

import SwiftUI

struct SettingsButtonView: View {
    @Binding var showSettings: Bool

    var body: some View {
        ZStack {
            Color(hex: "081325")
                .ignoresSafeArea()
            HStack {
                Spacer()
                Button(action: {
                    print("SettingsButtonView")
                    showSettings = true
                }) {
                    Image("SettingsNavBar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
                .padding(.trailing, 25)
                .padding(.top, 20)
            }
        }
        .frame(height: 80)
    }
}
