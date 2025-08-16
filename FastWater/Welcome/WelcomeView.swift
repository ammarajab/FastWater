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
            Image(Images.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image(Images.header)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 45)
                Text(Texts.title)
                    .title2(size: 45, letterSpacing: -3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 25)
                    .padding(.horizontal, 45)
                Text(Texts.subtitle)
                    .title(size: 25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.horizontal, 45)
                combinedText
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.horizontal, 45)
                Text(Texts.bodyPart2)
                    .body()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.horizontal, 45)
                Image(Images.footer)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .clipped()
                    .padding(.top, 30)
            }
            Button {
                coordinator.navigate(to: .dashboard)
            } label: {
                Text(Texts.button)
                    .title2()
                    .frame(height: 70)
                    .padding(.horizontal, 63)
                    .background(Color(hex: "1E2C4B"))
                    .cornerRadius(30)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 20)
            
        }
    }

    var combinedText: Text {
        Text(Texts.body1)
            .body()
        +
        Text(Texts.body2)
            .title2(size: 16, color: AppColors.textAccent)
        +
        Text(Texts.body3)
            .body()
    }

    struct Images {
        static let background = "WelcomeBackground"
        static let header = "WelcomeHeader"
        static let footer = "WelcomeFooter"
    }

    struct Texts {
        static let title = "Fast Smart, Hydrate Strong"
        static let subtitle = "Intermittent Fasting & Water Tracker"
        static let body1 = "The"
        static let body2 = " 16:8 fast "
        static let body3 = "boosts your metabolism and hydration ensures detox and hunger control."
        static let bodyPart1 = "The 16:8 fast boosts your metabolism and hydration ensures detox and hunger control."
        static let bodyPart2 = "Together, they improve fat loss, curbs hunger, and maintains focus—making the fast more effective and easier to sustain."
        static let button = "GET STARTED"
    }
}

#Preview {
    WelcomeView()
}
