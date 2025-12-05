//
//  WaterView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct WaterView: View {
    @Binding var showLoginPopup: Bool
    @Binding var showWaterReminderPicker: Bool
    @Binding var waterReminderPickerType: WaterReminderPickerType?
    @StateObject var viewModel: WaterViewModel
    @EnvironmentObject var authManager: AuthManager

    private let columns = Array(repeating: GridItem(.fixed(125), spacing: 15), count: 2)

    var body: some View {
        VStack {
            Text(Texts.title(glasses: viewModel.fullGlasses))
                .title()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 75)
                .padding(.top, 25)
            Spacer()
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(0 ..< viewModel.totalGlasses, id: \.self) { index in
                    Image(viewModel.waterCups[index] ? Images.waterFull : Images.waterEmpty)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 125.deviceScaled(), height: 125.deviceScaled())
                        .clipped()
                        .transition(.moveUp)
                        .onTapGesture {
                            handleGlassTapped(index: index)
                        }
                }
            }
            Spacer()
            Text(Texts.footerTitle(reminders: viewModel.totalGlasses))
                .body()
                .frame(maxWidth: .infinity, alignment: .center)
            TimeRangeView(
                showLoginPopup: $showLoginPopup,
                showWaterReminderPicker: $showWaterReminderPicker,
                waterReminderPickerType: $waterReminderPickerType,
                startTime: viewModel.startTimeText,
                endTime: viewModel.endTimeText,
                timeConnectText: Texts.footerSubtitle
            )
            Spacer()
        }
        .padding(.bottom, 8)
    }

    private func handleGlassTapped(index: Int) {
        if authManager.user == nil {
            showLoginPopup = true
        } else {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            withAnimation(.easeInOut(duration: 0.4)) {
                viewModel.toggleCup(index)
            }
        }
    }

    struct Images {
        static let waterFull = "WaterFull"
        static let waterEmpty = "WaterEmpty"
    }

    struct Texts {
        static func title(glasses: Int) -> String {
            "You’ve had \(glasses) glasses of water today!"
        }

        static func footerTitle(reminders: Int) -> String {
            "We will send \(reminders) hydration reminders between"
        }

        static let footerSubtitle = "     and     "
    }
}

struct TimeRangeView: View {
    @Binding var showLoginPopup: Bool
    @Binding var showWaterReminderPicker: Bool
    @Binding var waterReminderPickerType: WaterReminderPickerType?
    @EnvironmentObject var authManager: AuthManager

    var startTime: String
    var endTime: String
    let timeConnectText: String

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Button {
                handleTimeTapped(pickerType: .start)
            } label: {
                Text(startTime)
                    .title2(color: AppColors.textAccent)
                    .underline()
            }
            Text(timeConnectText)
                .body()
            Button {
                handleTimeTapped(pickerType: .end)
            } label: {
                Text(endTime)
                    .title2(color: AppColors.textAccent)
                    .underline()
            }
            Spacer()
        }
    }

    private func handleTimeTapped(pickerType: WaterReminderPickerType) {
        if authManager.user == nil {
            showLoginPopup = true
        } else {
            showWaterReminderPicker = true
            waterReminderPickerType = pickerType
        }
    }

}
