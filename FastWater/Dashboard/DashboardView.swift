//
//  DashboardView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    enum Tab: String {
        case fast, calendar, water
    }

    @State private var selectedTab: Tab = .fast
    @State private var showSettings = false
    @State private var showFastPopup = false
    @State private var showWaterReminderPicker = false
    @State private var waterReminderPickerType: WaterReminderPickerType?
    @EnvironmentObject private var fastingManager: FastingManager
    @EnvironmentObject private var fastingRecordManager: FastingRecordManager
    @Environment(\.modelContext) private var modelContext
    @StateObject private var fastViewModel: FastViewModel
    @StateObject private var calendarViewModel: CalendarViewModel
    @StateObject private var waterViewModel: WaterViewModel

    init() {
        let repo = SwiftDataFastingRepository(context: ModelContext(try! ModelContainer(for: CurrentFast.self, FastsContainer.self, WaterInfo.self)))
        let fastingRecordManager = FastingRecordManager(repo: repo)
        let fastingRepo = SwiftDataFastingRepository(context: repo.context)
        _fastViewModel = StateObject(wrappedValue: FastViewModel(fastingManager: FastingManager(fastingRecordManager: fastingRecordManager, repo: fastingRepo)))
        _calendarViewModel = StateObject(wrappedValue: CalendarViewModel(fastingRecordManager: fastingRecordManager))
        _waterViewModel = StateObject(wrappedValue: WaterViewModel(waterManager: WaterManager(repo: fastingRepo)))
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
                        WaterView(showWaterReminderPicker: $showWaterReminderPicker,
                                  waterReminderPickerType: $waterReminderPickerType,
                                  viewModel: waterViewModel)
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
                BlurBackgroundView()
                SettingsView(showSettings: $showSettings)
            }
            if showFastPopup {
                BlurBackgroundView()
                    .onTapGesture {
                        showFastPopup = false
                    }
                FastPopupView(showFastPopup: $showFastPopup)
                    .environmentObject(fastViewModel)
            }
            if showWaterReminderPicker,
               let waterReminderPickerType {
                BlurBackgroundView()
                    .onTapGesture {
                        showWaterReminderPicker = false
                    }
                WaterReminderPickerView(pickerType: waterReminderPickerType,
                                        showWaterReminderPicker: $showWaterReminderPicker,
                                        viewModel: waterViewModel)
            }
        }
        .animation(.easeInOut, value: showSettings)
        .animation(.easeInOut, value: showFastPopup)
        .animation(.easeInOut, value: showWaterReminderPicker)
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
