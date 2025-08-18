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
        Button(action: {
            showSettings.toggle()
        }) {
            Image(Images.settings)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(.trailing, 25)
        .padding(.top, 20)
    }

    struct Images {
        static let settings = "SettingsNavBar"
    }
}
