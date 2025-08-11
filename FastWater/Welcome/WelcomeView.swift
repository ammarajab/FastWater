//
//  WelcomeView.swift
//  FastWater
//
//  Created by Ammar on 27/07/2025.
//

import SwiftUI

struct WelcomeView: View {

    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        ZStack {
            Image("WelcomeBackground")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image("WelcomeHeader")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 45)
                Text("Fast Smart, Hydrate Strong")
                    .font(
                        Font.custom("Lato-Black", size: 45)
                    )
                    .kerning(-3)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 25)
                    .padding(.horizontal, 45)
                Text("Intermittent Fasting & Water Tracker")
                    .font(
                        Font.custom("Lato-BlackItalic", size: 25)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.horizontal, 45)
                Text(combinedText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.horizontal, 45)
                Text("Together, they improve fat loss, curbs hunger, and maintains focus—making the fast more effective and easier to sustain.")
                    .font(
                        Font.custom("Lato-Regular", size: 16)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.horizontal, 45)
                Image("WelcomeFooter")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .clipped()
                    .padding(.top, 30)
            }
            Button {
                coordinator.navigate(to: .dashboard)
            } label: {
                Text("GET STARTED")
                    .font(
                        Font.custom("Lato-Black", size: 24)
                    )
                    .foregroundStyle(.white)
                    .frame(height: 70)
                    .padding(.horizontal, 63)
                    .background(Color(hex: "1E2C4B"))
                    .cornerRadius(30)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 20)
            
        }
    }

    var combinedText: AttributedString {
        var text1 = AttributedString("The ")
        text1.font = .custom("Lato-Regular", size: 16)
        text1.foregroundColor = .white

        var text2 = AttributedString("16:8")
        text2.font = .custom("Lato-Black", size: 16)
        text2.foregroundColor = Color(hex: "F0C078")

        var text3 = AttributedString(" fast boosts your metabolism and hydration ensures detox and hunger control.")
        text3.font = .custom("Lato-Regular", size: 16)
        text3.foregroundColor = .white

        return text1 + text2 + text3
    }
}

#Preview {
    WelcomeView()
}
