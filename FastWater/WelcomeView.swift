//
//  WelcomeView.swift
//  FastWater
//
//  Created by Ammar on 27/07/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Image("WelcomeBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("WelcomeFooter")
                        .padding(.bottom, 15)
                }
            }
            VStack {
                HStack {
                    Image("WelcomeHeader")
                    Spacer()
                }
                Text("Fast Smart, Hydrate Strong")
                    .font(
                        Font.custom("Lato-Black", size: 45)
                    )
                    .kerning(-3)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                Text("Intermittent Fasting & Water Tracker")
                    .font(
                        Font.custom("Lato-BlackItalic", size: 25)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 25)
                Text(combinedText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                Text("Together, they improve fat loss, curbs hunger, and maintains focus—making the fast more effective and easier to sustain.")
                    .font(
                        Font.custom("Lato-Regular", size: 16)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                Spacer()
            }
            .padding(.top, 30)
            .padding([.horizontal, .bottom], 45)
            VStack {
                Spacer()
                Button {
                    print("I was clicked")
                } label: {
                    Text("GET STARTED")
                        .font(
                            Font.custom("Lato-Black", size: 24)
                        )
                        .foregroundStyle(.white)
                        .frame(width: 314, height: 70)
                        .background(Color(hex: "1E2C4B"))
                        .cornerRadius(30)
                }
                .padding(.bottom, 60)
            }
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

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
