//
//  WaterReminderPickerView.swift
//  FastWater
//
//  Created by Ammar on 23/08/2025.
//

import SwiftUI

typealias WaterReminderPickerType = WaterReminderPickerView.PickerType

struct WaterReminderPickerView: View {

    enum PickerType {
        case start, end
    }

    let title: String
    let type: WaterReminderPickerType
    @Binding var showWaterReminderPicker: Bool
    @StateObject var viewModel: WaterViewModel

    init(pickerType: PickerType, showWaterReminderPicker: Binding<Bool>, viewModel: WaterViewModel ) {
        self.type = pickerType
        self.title = Texts.title(pickerType: pickerType)
        self._showWaterReminderPicker = showWaterReminderPicker
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .title2()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            DatePicker(
                "",
                selection: getSelection(),
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .colorScheme(.dark)
            .frame(height: 150)
            Button(action: {
                showWaterReminderPicker = false
            }) {
                Text(Texts.save)
                    .title()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
        .background(AppColors.backgroundPrimary)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        .frame(maxWidth: 300)
        .transition(.scale)
        .zIndex(1)
    }

    private func getSelection() -> Binding<Date> {
        switch type {
        case .start:
            return $viewModel.reminderStart
        case .end:
            return $viewModel.reminderEnd
        }
    }

    struct Texts {
        static func title(pickerType: PickerType) -> String {
            switch pickerType {
            case .start:
                return "Hydration reminders start at"
            case .end:
                return "Hydration reminders end at"
            }
        }

        static let save = "Save"
    }
}
