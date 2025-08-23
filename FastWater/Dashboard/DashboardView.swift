//
//  DashboardView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct DashboardView: View {
    enum Tab: String {
        case fast, calendar, water
    }

    @State private var selectedTab: Tab = .fast
    @State private var showSettings = false
    @State private var showFastPopup = false
    @EnvironmentObject private var fastingManager: FastingManager
    @EnvironmentObject private var fastingRecordManager: FastingRecordManager
    @StateObject private var fastViewModel: FastViewModel
    @StateObject private var calendarViewModel: CalendarViewModel

    init() {
        let fastingRecordManager = FastingRecordManager()
        _fastViewModel = StateObject(wrappedValue: FastViewModel(fastingManager: FastingManager(fastingRecordManager: fastingRecordManager)))
        _calendarViewModel = StateObject(wrappedValue: CalendarViewModel(fastingRecordManager: fastingRecordManager))
    }

    var body: some View {
        ZStack {
            AppColors.backgroundPrimary
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case .fast:
                        FastView(showFastPopup: $showFastPopup)
                            .environmentObject(fastViewModel)
                    case .calendar:
                        CalendarView()
                            .environmentObject(calendarViewModel)
                    case .water:
                        WaterView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                HStack {
                    tabBarItem(tab: .fast, imageName: Images.fast)
                    tabBarItem(tab: .calendar, imageName: Images.calendar)
                    tabBarItem(tab: .water, imageName: Images.water)
                }
                .frame(height: 150.deviceScaled())
                .background(AppColors.backgroundMuted)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .edgesIgnoringSafeArea(.bottom)
            SettingsButtonView(showSettings: $showSettings)
            if showSettings {
                ZStack {
                    AppColors.backgroundPrimary.opacity(0.3).ignoresSafeArea()
                    VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
                        .ignoresSafeArea()
                }
                SettingsView(showSettings: $showSettings)
            }
            if showFastPopup {
                AppColors.backgroundPrimary.opacity(0.3).ignoresSafeArea()
                VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showFastPopup = false
                    }
                FastPopupView(showFastPopup: $showFastPopup)
                    .environmentObject(fastViewModel)
            }
        }
        .animation(.easeInOut, value: showFastPopup)
        .animation(.easeInOut, value: showSettings)
    }

    private func tabBarItem(tab: Tab, imageName: String) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            ZStack {
                if selectedTab == tab {
                    Rectangle()
                        .fill(AppColors.backgroundPrimary)
                        .frame(width: UIScreen.main.bounds.width / 3, height: 150.deviceScaled())
                }
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 108.deviceScaled(), height: 108.deviceScaled())
            }
            .frame(maxWidth: .infinity)
        }
    }

    struct Images {
        static let fast = "FastTabBar"
        static let calendar = "CalendarTabBar"
        static let water = "WaterTabBar"
    }
}
