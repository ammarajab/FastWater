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
    @StateObject var viewModel: SettingsViewModel
    @EnvironmentObject var authManager: AuthManager

//    private let waterManager: WaterManager
//    var reminderStart: Date = Date()
//    var reminderEnd: Date = Date()

//    init(waterManager: WaterManager) {
//        self.waterManager = waterManager
//        waterRemindersEnabled = UserDefaults.standard.bool(forKey: "waterReminderEnabled")
//    }

    var body: some View {
        ZStack( alignment: .top) {
            RoundedRectangle(cornerRadius: 25)
                .fill(AppColors.backgroundInverse)
                .padding(.horizontal, 15)
                .padding(.top, 10)
                .padding(.bottom, 25.deviceScaled())
            Rectangle()
                .fill(AppColors.backgroundTertiary)
                .frame(height: 318.deviceScaled())
                .padding(.horizontal, 15)
                .padding(.top, 114)
            VStack (spacing: 0){
                Text(Texts.title)
                    .title(color: AppColors.textInverse)
                    .foregroundStyle(AppColors.textInverse)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 15)
                Image(Images.header)
                    .padding(.top, 10)
                combinedText
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(Texts.subscribeTitle)
                    .title2(size: 40)
                    .frame(maxWidth: .infinity, alignment: .center)
                Button {
                    
                } label: {
                    Text(Texts.subscribe1)
                        .title2()
                        .frame(width: 251.deviceScaled(), height: 56.deviceScaled())
                        .background(AppColors.buttonPrimary)
                        .cornerRadius(30)
                }
                .padding(.top, 20)
                ZStack{
                    Button {
                        
                    } label: {
                        Text(Texts.subscribe2)
                            .title2(size: 30)
                            .frame(width: 314.deviceScaled(), height: 70.deviceScaled())
                            .background(AppColors.buttonPrimary)
                            .cornerRadius(30)
                    }
                    Image(Images.subscribe)
                        .resizable()
                        .frame(width: 80.deviceScaled(), height: 80.deviceScaled())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.leading, 20)
                }
                .frame(height: 145.deviceScaled())
                HStack {
                    Text(Texts.whyFast)
                        .title2(color: AppColors.textInverse)
                    Spacer()
                    Button(action: {
                        showWhyFast = true
                    }) {
                        Image(Images.next)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 55, height: 55)
                    }
                }
                .padding(.horizontal, 30)
                .frame(height: 80.deviceScaled())
                Rectangle()
                    .fill(AppColors.backgroundSeparator)
                    .frame(height: 1)
                HStack {
                    Text(Texts.waterReminders)
                        .body(size: 24, color: AppColors.textInverse)
                    Spacer()
                    Toggle("", isOn: $viewModel.waterRemindersEnabled)
                    .labelsHidden()
                    .toggleStyle(WideToggleStyle())
                    .frame(width: 80, height: 40)
                }
                .padding(.horizontal, 30)
                .frame(height: 80.deviceScaled())
                Rectangle()
                    .fill(AppColors.backgroundSeparator)
                    .frame(height: 1)
                Button {
                    
                } label: {
                    Text(Texts.share)
                        .body(size: 24, color: AppColors.textInverse)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 30)
                .frame(height: 80.deviceScaled())
                Rectangle()
                    .fill(AppColors.backgroundSeparator)
                    .frame(height: 1)
                Button {
                    authManager.signOut()
                } label: {
                    Text(Texts.logout)
                        .body(size: 24, color: AppColors.textInverse)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 30)
                .frame(height: 80.deviceScaled())
                Rectangle()
                    .fill(AppColors.backgroundSeparator)
                    .frame(height: 1)
                Button {
                    showSettings = false
                } label: {
                    Text(Texts.close)
                        .title2(size: 18, color: AppColors.textCritical)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(height: 80.deviceScaled())
            }
            .padding(.horizontal, 15)
            .padding(.top, 20)
            SettingsButtonView(showSettings: $showSettings)
            if showWhyFast {
                WhyFastView(showWhyFast: $showWhyFast)
            }
            
            if viewModel.showNotificationAlert {
                ZStack {
                    // Dimmed background
                    Color.black.opacity(0.35)
                        .ignoresSafeArea()

                    // Alert card
                    VStack(spacing: 20) {
                        // Icon
                        Image(systemName: "bell.badge.fill")
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundColor(AppColors.textAccent)

                        // Title
                        Text("Enable Notifications")
                            .font(.title3.weight(.semibold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)

                        // Message
                        Text("To receive reminders, please enable notifications in Settings.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)

                        // Buttons
                        HStack(spacing: 12) {
                            Button {
                                withAnimation {
                                    viewModel.showNotificationAlert = false
                                }
                            } label: {
                                Text("Cancel")
                                    .font(.body)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                    )
                                    .foregroundColor(.black)
                            }

                            Button {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(url)
                                }
                                withAnimation {
                                    viewModel.showNotificationAlert = false
                                }
                            } label: {
                                Text("Open Settings")
                                    .font(.body.weight(.semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white.opacity(0.9))
                                    )
                                    .foregroundColor(.black) // 👈 stays black
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 22)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                    )
                    .padding(.horizontal, 32)
                }
                .transition(.scale.combined(with: .opacity))
                .animation(.easeInOut(duration: 0.25), value: viewModel.showNotificationAlert)
            }

        }
        .onAppear {
            viewModel.updateValues()
        }
//        .alert("Enable Notifications",
//               isPresented: $viewModel.showNotificationAlert) {
//            Button {
//                if let url = URL(string: UIApplication.openSettingsURLString) {
//                    UIApplication.shared.open(url)
//                }
//            } label: {
//                Text("Open Settings")
//                    .body(size: 24, color: AppColors.textInverse)
//            }
//            Button(role: .cancel) {
//            } label: {
//                Text("Cancel")
//                    .body(size: 24, color: AppColors.textInverse)
//            }
//        } message: {
//            Text("To receive reminders, please enable notifications in Settings.")
//                .body(size: 24, color: AppColors.textInverse)
//        }
    }

    var combinedText: Text {
        Text(Texts.subtitle1)
            .body()
        +
        Text(Texts.subtitle2)
            .title2(size: 16, color: AppColors.textCritical)
        +
        Text(Texts.subtitle3)
            .body()
    }

    struct Images {
        static let header = "SettingsHeader"
        static let subscribe = "SettingsSubscribe"
        static let next = "SettingsNext"
    }

    struct Texts {
        static let title = "Settings"
        static let subtitle1 = "You have"
        static let subtitle2 = " 1 day "
        static let subtitle3 = "left of your 3 day trial"
        static let subscribeTitle = "Subscribe Now"
        static let subscribe1 = "$1.99 per month"
        static let subscribe2 = "$19.99 per year"
        static let whyFast = "Why Fast?"
        static let waterReminders = "Water Reminders"
        static let share = "Share with a friend"
        static let logout = "Logout"
        static let close = "CLOSE"
    }
}

struct WideToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(configuration.isOn ? AppColors.shapeActive : AppColors.shapeInactive)
            .frame(width: 83, height: 37)
            .overlay(
                Circle()
                    .fill(AppColors.shapeMain)
                    .frame(width: 29, height: 29)
                    .offset(x: configuration.isOn ? 23 : -23)
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
            )
            .onTapGesture { configuration.isOn.toggle() }
    }
}
