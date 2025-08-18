//
//  SettingsView.swift
//  FastWater
//
//  Created by Ammar on 08/08/2025.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    @State private var waterReminderOn = false
    @State var showWhyFast = false

    var body: some View {
        ZStack( alignment: .top) {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .padding(.horizontal, 15)
                .padding(.top, 10)
                .padding(.bottom, 30)
            Rectangle()
                .fill(Color(hex: "20293A"))
                .frame(height: 318)
                .padding(.horizontal, 15)
                .padding(.top, 114)
            VStack (spacing: 0){
                Text("Settings")
                    .font(
                        Font.custom("Lato-BlackItalic", size: 32)
                    )
                    .foregroundStyle(Color(hex: "081325"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 15)
                Image("SettingsHeader")
                    .padding(.top, 10)
                Text(combinedText)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Subscribe Now")
                    .font(
                        Font.custom("Lato-Bold", size: 40)
                    )
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                Button {
                    
                } label: {
                    Text("$1.99 per month")
                        .font(
                            Font.custom("Lato-Black", size: 24)
                        )
                        .foregroundStyle(.white)
                        .frame(width: 251, height: 56)
                        .background(Color(hex: "F96758"))
                        .cornerRadius(30)
                }
                .padding(.top, 20)
                ZStack{
                    Button {
                        
                    } label: {
                        Text("$19.99 per year")
                            .font(
                                Font.custom("Lato-Black", size: 30)
                            )
                            .foregroundStyle(.white)
                            .frame(width: 314, height: 70)
                            .background(Color(hex: "F96758"))
                            .cornerRadius(30)
                    }
                    Image("SettingsSubscribe")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.leading, 20)
                }
                .frame(height: 145)
                HStack {
                    Text("Why Fast?")
                        .font(
                            Font.custom("Lato-Black", size: 24)
                        )
                        .foregroundStyle(Color(hex: "081325"))
                    Spacer()
                    Button(action: {
                        showWhyFast = true
                    }) {
                        Image("SettingsNext")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 55, height: 55)
                    }
                }
                .padding(.horizontal, 30)
                .frame(height: 80)
                Rectangle()
                    .fill(Color(hex: "B8B8B8"))
                    .frame(height: 1)
                HStack {
                    Text("Water Reminders")
                        .font(
                            Font.custom("Lato-Regular", size: 24)
                        )
                        .foregroundStyle(Color(hex: "081325"))
                    Spacer()
                    Toggle(isOn: $waterReminderOn) {
                        Text("Enable Feature")
                    }
                    .labelsHidden()
//                    .toggleStyle(SwitchToggleStyle(tint: Color(hex: "FF9500")))
                    .toggleStyle(WideToggleStyle())
                    .frame(width: 80, height: 40)
                }
                .padding(.horizontal, 30)
                .frame(height: 80)
                Rectangle()
                    .fill(Color(hex: "B8B8B8"))
                    .frame(height: 1)
                Button {
                    
                } label: {
                    Text("Rate us on the App Store")
                        .font(
                            Font.custom("Lato-Regular", size: 24)
                        )
                        .foregroundStyle(Color(hex: "081325"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 30)
                .frame(height: 80)
                Rectangle()
                    .fill(Color(hex: "B8B8B8"))
                    .frame(height: 1)
                Button {
                    
                } label: {
                    Text("Share with a friend")
                        .font(
                            Font.custom("Lato-Regular", size: 24)
                        )
                        .foregroundStyle(Color(hex: "081325"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 30)
                .frame(height: 80)
                Rectangle()
                    .fill(Color(hex: "B8B8B8"))
                    .frame(height: 1)
                Button {
                    showSettings = false
                } label: {
                    Text("CLOSE")
                        .font(
                            Font.custom("Lato-Black", size: 18)
                        )
                        .foregroundStyle(Color(hex: "F96758"))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(height: 80)
            }
            .padding(.horizontal, 15)
            .padding(.top, 20)
            SettingsButtonView(showSettings: $showSettings)
            if showWhyFast {
                WhyFastView(showWhyFast: $showWhyFast)
            }

        }
    }

    var combinedText: AttributedString {
        var text1 = AttributedString("You have")
        text1.font = .custom("Lato-Regular", size: 16)
        text1.foregroundColor = .white

        var text2 = AttributedString(" 1 day ")
        text2.font = .custom("Lato-Regular", size: 16)
        text2.foregroundColor = Color(hex: "F96758")

        var text3 = AttributedString("left of your 3 day trial")
        text3.font = .custom("Lato-Regular", size: 16)
        text3.foregroundColor = .white
        
        return text1 + text2 + text3
    }
}

struct WideToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(configuration.isOn ? Color(hex: "FF9500") : Color(hex: "e9e9eb"))
            .frame(width: 83, height: 37)
            .overlay(
                Circle()
                    .fill(Color.white)
                    .frame(width: 29, height: 29)
                    .offset(x: configuration.isOn ? 23 : -23)
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
            )
            .onTapGesture { configuration.isOn.toggle() }
    }
}
