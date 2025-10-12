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
                .fill(AppColors.backgroundTertiary)
                .padding(.horizontal, 14)
                .padding(.top, 9)
                .padding(.bottom, 9)
                VStack (spacing: 0){
                    Button(action: {
                        showWhyFast = false
                    }) {
                        Image(Images.back)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, 40)
                    .padding(.top, 35)
                    ScrollView {
                        VStack (spacing: 0){
                            Text(Texts.screenTitle)
                                .title2(size: 45, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 22)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            Text(Texts.title1)
                                .title(size: 25, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 40)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            Text(Texts.body1)
                                .body(size: 16, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            Text(Texts.subtitle11)
                                .title2(size: 16, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            VStack(alignment: .leading, spacing: 18) {
                                Label {
                                    Text(Texts.listTitle111)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody111)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                                Label {
                                    Text(Texts.listTitle112)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody112)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                                Label {
                                    Text(Texts.listTitle113)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody113)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                            }
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                            .padding(.top, 18)
                            .padding(.leading, 75)
                            .padding(.trailing, 45)
                            Text(Texts.subtitle12)
                                .title2(size: 16, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            VStack(alignment: .leading, spacing: 18) {
                                Label {
                                    Text(Texts.listTitle121)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody121)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                                Label {
                                    Text(Texts.listTitle122)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody122)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                            }
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                            .padding(.top, 18)
                            .padding(.leading, 75)
                            .padding(.trailing, 45)
                            Text(Texts.subtitle13)
                                .title2(size: 16, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            VStack(alignment: .leading, spacing: 18) {
                                Label {
                                    Text(Texts.listBody131)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                            }
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                            .padding(.top, 18)
                            .padding(.leading, 75)
                            .padding(.trailing, 45)
                            Text(Texts.title2)
                                .title(size: 25, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 40)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            Text(Texts.body2)
                                .body(size: 16, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            Text(Texts.subtitle21)
                                .title2(size: 16, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            VStack(alignment: .leading, spacing: 18) {
                                Label {
                                    Text(Texts.listTitle211)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody211)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                                Label {
                                    Text(Texts.listTitle212)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody212)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                            }
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                            .padding(.top, 18)
                            .padding(.leading, 75)
                            .padding(.trailing, 45)
                            Text(Texts.subtitle22)
                                .title2(size: 16, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            VStack(alignment: .leading, spacing: 18) {
                                Label {
                                    Text(Texts.listTitle221)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody221)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                            }
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                            .padding(.top, 18)
                            .padding(.leading, 75)
                            .padding(.trailing, 45)
                            Text(Texts.subtitle23)
                                .title2(size: 16, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            VStack(alignment: .leading, spacing: 18) {
                                Label {
                                    Text(Texts.listTitle231)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody231)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                                Label {
                                    Text(Texts.listTitle232)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody232)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                            }
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                            .padding(.top, 18)
                            .padding(.leading, 75)
                            .padding(.trailing, 45)
                            Text(Texts.subtitle24)
                                .title2(size: 16, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            VStack(alignment: .leading, spacing: 18) {
                                Label {
                                    Text(Texts.listTitle241)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody241)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                                Label {
                                    Text(Texts.listTitle242)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody242)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                            }
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                            .padding(.top, 18)
                            .padding(.leading, 75)
                            .padding(.trailing, 45)
                            Text(Texts.title3)
                                .title(size: 25, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 40)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            VStack(alignment: .leading, spacing: 18) {
                                Label {
                                    Text(Texts.listTitle31)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody31)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                                Label {
                                    Text(Texts.listTitle32)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody32)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                                Label {
                                    Text(Texts.listTitle33)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody33)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                                Label {
                                    Text(Texts.listTitle34)
                                        .font(.custom("Lato-Black", size: 16)) +
                                    Text(Texts.listBody34)
                                        .font(.custom("Lato-Regular", size: 16))
                                } icon: {
                                    Image(systemName: "circlebadge.fill")
                                }
                                .foregroundStyle(AppColors.textPrimary)
                            }
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                            .padding(.top, 18)
                            .padding(.leading, 45)
                            .padding(.trailing, 15)
                            Text(Texts.title4)
                                .title(size: 25, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 40)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                            Text(Texts.body4)
                                .body(size: 16, scale: false)
                                .foregroundStyle(AppColors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.leading, 45)
                                .padding(.trailing, 15)
                        }
                    }
                    .padding(.trailing, 30)
                    .padding(.bottom, 30)
                }
                .padding(.bottom, 20)
        }
    }

    struct Images {
        static let back = "SettingsBack"
    }

    struct Texts {
        static let screenTitle = "Why Fast?"
        static let title1 = "Why 16:8 Intermittent Fasting Packs the Biggest Punch"
        static let title2 = "Why Water Supercharges 16:8"
        static let title3 = "Hydration Playbook for 16:8"
        static let title4 = "The Takeaway"
        static let body1 = "The 16:8 approach—fasting for 16 hours, eating within an 8‑hour window—hits a sweet spot between effectiveness and day‑to‑day livability. Here’s what the science says:"
        static let body2 = "Staying well‑hydrated doesn’t just make fasting easier—it multiplies the upsides."
        static let body4 = "Pairing 16:8 intermittent fasting with consistent hydration forms a powerful synergy: fasting drives metabolic and cellular benefits, while water keeps every system humming, curbs hunger, and smooths out bumps like fatigue or brain fog.\nThe result is a routine that’s highly effective, sustainable, and kinder to both body and mind."
        static let subtitle11 = "Metabolic & Hormonal Upgrades"
        static let subtitle12 = "Heart & Brain Perks"
        static let subtitle13 = "Universally Adaptable"
        static let subtitle21 = "Metabolic Efficiency"
        static let subtitle22 = "Hunger Tamer"
        static let subtitle23 = "Side‑Effect Buffer"
        static let subtitle24 = "Performance & Clarity"
        static let listTitle111 = "Reliable Fat Burning. "
        static let listTitle112 = "Cellular \"Spring Cleaning.\" "
        static let listTitle113 = "Sharper Insulin Response. "
        static let listTitle121 = "Cardio Boost. "
        static let listTitle122 = "Brain Gains. "
        static let listTitle211 = "Fat‑Fuel Pipeline. "
        static let listTitle212 = "Detox Support. "
        static let listTitle221 = "Stomach Stretch. "
        static let listTitle231 = "No Dehydration Drag. "
        static let listTitle232 = "Electrolyte Stability. "
        static let listTitle241 = "Energy on Tap. "
        static let listTitle242 = "Sharper Thinking. "
        static let listTitle31 = "Daily Target: "
        static let listTitle32 = "Electrolyte Boost: "
        static let listTitle33 = "Fast‑Friendly Drinks: "
        static let listTitle34 = "Check Your Color: "
        static let listBody111 = "Once glycogen runs low (≈12–14 hours of fasting), your body pivots to burning fat for fuel. The extra couple of hours to reach 16 ensures you’re solidly in that fat‑oxidizing zone—great for weight loss without stripping muscle."
        static let listBody112 = "Around the 14‑ to 16‑hour mark, autophagy— your body’s built‑in recycling service—kicks into high gear, quietly lowering inflammation and supporting longevity."
        static let listBody113 = "Lower insulin levels during the fast can improve insulin sensitivity and steady your blood sugar, bolstering type 2 diabetes prevention."
        static let listBody121 = "Consistent 16:8 fasting has been linked to lower blood pressure, LDL cholesterol, and triglycerides."
        static let listBody122 = "Fasting elevates brain‑derived neurotrophic factor (BDNF), a protein tied to memory and mood."
        static let listBody131 = "Whether you’re lean, overweight, or managing metabolic issues, 16:8 delivers benefits without the extreme cuts of 24‑hour fasts or the stop‑start rhythm of a 5:2 plan."
        static let listBody211 = "Water helps shuttle fatty acids and ketones around the body, making fat‑burning more seamless."
        static let listBody212 = "Breaking down fat releases stored toxins; ample fluid lets your kidneys and liver flush them out."
        static let listBody221 = "A glass or two of water calms hunger waves and keeps you from mistaking thirst for \"I need food NOW. \""
        static let listBody231 = "Reduced food means less water from meals and a drop in glycogen‑bound water, so topping up fluids wards off headaches, fatigue, and crankiness."
        static let listBody232 = "A pinch of salt (or a sugar‑free electrolyte mix) keeps sodium, potassium, and magnesium in balance, preventing muscle cramps and dizziness."
        static let listBody241 = "Hydration maintains blood volume and oxygen delivery, so workouts and work meetings feel smoother—even in a fasted state."
        static let listBody242 = "Fasting lifts BDNF; hydration protects cognitive function. Together, they dial up focus and mental clarity."
        static let listBody31 = "2–3 liters of water, spread across the whole day."
        static let listBody32 = "Add a pinch of mineral‑rich salt or a zero‑calorie electrolyte tab."
        static let listBody33 = "Black coffee, unsweetened tea, and plain or sparkling water all keep you in the fast."
        static let listBody34 = "Pale‑yellow urine = well hydrated; darker = drink up."
    }
}
