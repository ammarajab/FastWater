//
//  CalendarViewModel.swift
//  FastWater
//
//  Created by Ammar on 22/08/2025.
//

import SwiftUI
import Combine

@MainActor
final class CalendarViewModel: ObservableObject {
    private let fastingRecordManager: FastingRecordManager
    private let calendar = Calendar.current
    private var cancellables = Set<AnyCancellable>()
    let weekDays: [String] = Calendar.current.shortWeekdaySymbols
    var selectedMonth: Int
    @Published var selectedYear: Int
    @Published var numberOfDays: Int
    @Published var firstWeekdayIndex: Int
    @Published var selectedMonthFasts: [Fast] = []
    @Published var hoursFasted: Int = 0

    var selectedMonthText: String {
        DateFormatter().monthSymbols[selectedMonth - 1]
    }

    init(fastingRecordManager: FastingRecordManager) {
        self.fastingRecordManager = fastingRecordManager
        let comps = calendar.dateComponents([.year, .month], from: Date())
        self.selectedMonth = comps.month ?? 1
        self.selectedYear  = comps.year ?? 2025
        self.numberOfDays = 0
        self.firstWeekdayIndex = 0
        updateMonthMetadata()
        reloadSelectedMonthFasts()
        fastingRecordManager.$fasts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.reloadSelectedMonthFasts()
            }
            .store(in: &cancellables)
    }

    func changeMonth(by value: Int) {
        let current = calendar.date(from: DateComponents(year: selectedYear, month: selectedMonth, day: 1))!
        let next = calendar.date(byAdding: .month, value: value, to: current)!
        let comps = calendar.dateComponents([.year, .month], from: next)
        selectedMonth = comps.month ?? 1
        selectedYear  = comps.year ?? 2025
        updateMonthMetadata()
        reloadSelectedMonthFasts()
    }

    private func updateMonthMetadata() {
        let firstOfMonth = calendar.date(from: DateComponents(year: selectedYear, month: selectedMonth, day: 1))!
        let range = calendar.range(of: .day, in: .month, for: firstOfMonth)!
        numberOfDays = range.count
        firstWeekdayIndex = calendar.component(.weekday, from: firstOfMonth) - 1
    }

    private func reloadSelectedMonthFasts() {
        let yearFasts = fastingRecordManager.fasts[selectedYear]
        let monthFasts = yearFasts?[selectedMonth]
        selectedMonthFasts = monthFasts ?? []
        let secondsFasted = selectedMonthFasts.reduce(0) { partialResult, fast in
            partialResult + fast.endTime.timeIntervalSince(fast.startTime)
        }
        hoursFasted = Int(secondsFasted / (60*60))
    }

    func colorForDay(day: Int) -> Color {
        let isFastingDay = selectedMonthFasts.contains {
            Calendar.current.component(.day, from: $0.endTime) == day
        }
        return isFastingDay ? AppColors.shapeCritical : AppColors.shapeMuted
    }
}
