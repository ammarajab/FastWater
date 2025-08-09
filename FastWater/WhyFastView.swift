//
//  WhyFastView.swift
//  FastWater
//
//  Created by Ammar on 09/08/2025.
//

import SwiftUI

struct WhyFastView: View {
    @Binding var showWhyFast: Bool

    var body: some View {
        ZStack( alignment: .top) {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(hex: "20293A"))
                .padding(.horizontal, 14)
                .padding(.top, 19)
                .padding(.bottom, 29)
                VStack (spacing: 0){
                    Button(action: {
                        showWhyFast = false
                    }) {
                        Image("SettingsBack")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, 40)
                    .padding(.top, 45)
                    ScrollView {
                        VStack (spacing: 0){
                            Text("Why Fast?")
                                .font(
                                    Font.custom("Lato-Bold", size: 45)
                                )
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 22)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            Text("Why 16:8 Intermittent Fasting Packs the Biggest Punch")
                                .font(
                                    Font.custom("Lato-BlackItalic", size: 25)
                                )
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 37)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            Text("The 16:8 approach—fasting for 16 hours, eating within an 8‑hour window—hits a sweet spot between effectiveness and day‑to‑day livability.\n\nHere’s what the science says:\n\n  1. Metabolic & Hormonal Upgrades")
                                .font(
                                    Font.custom("Lato-Bold", size: 16)
                                )
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 42)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            VStack(alignment: .leading, spacing: 18) {
                                Label("Cellular “Spring Cleaning.” Around the 14‑ to 16‑hour mark, autophagy—your body’s built‑in recycling service—kicks into high gear, quietly lowering inflammation and supporting longevity.", systemImage: "circlebadge.fill")
                                    .font(
                                        Font.custom("Lato-Bold", size: 16)
                                    )
                                    .foregroundStyle(Color.white)
                                Label("Sharper Insulin Response. Lower insulin levels during the fast can improve insulin sensitivity and steady your blood sugar, bolstering type 2 diabetes prevention.", systemImage: "circlebadge.fill")
                                    .font(
                                        Font.custom("Lato-Bold", size: 16)
                                    )
                                    .foregroundStyle(Color.white)
                                Label("Reliable Fat Burning. Once glycogen runs low (≈12–14 hours), your body pivots to burning fat for fuel. The extra couple of hours to reach 16 ensures you’re solidly in that fat‑oxidizing zone—great for weight loss without stripping muscle.", systemImage: "circlebadge.fill")
                                    .font(
                                        Font.custom("Lato-Bold", size: 16)
                                    )
                                    .foregroundStyle(Color.white)
                            }
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                            .padding(.top, 18)
                            .padding(.leading, 75)
                            .padding(.trailing, 45)
                        }
                }
//                .padding(.bottom, 30)
                .padding(.trailing, 30)
                .padding(.bottom, 30)
//                .padding(.top, 120)
                }
                .padding(.bottom, 30)
        }
    }
}

#Preview {
    WhyFastView(showWhyFast: .constant(false))
}
