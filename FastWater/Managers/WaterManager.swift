//
//  WaterManager.swift
//  FastWater
//
//  Created by Ammar on 23/08/2025.
//

import Foundation
import Combine

@MainActor
public final class WaterManager: ObservableObject {
//    @Published private(set) var waterCups: [Bool] = [false,false,false,false,false,false,false,false]
//    @Published private(set) var reminderStart: Date = {
//        var comps = DateComponents()
//        comps.hour = 7
//        comps.minute = 0
//        return Calendar.current.date(from: comps) ?? Date()
//    }()
//    @Published private(set) var reminderEnd: Date = {
//        var comps = DateComponents()
//        comps.hour = 21
//        comps.minute = 0
//        return Calendar.current.date(from: comps) ?? Date()
//    }()

    @Published private(set) var waterCups: [Bool]
    @Published var reminderStart: Date
    @Published var reminderEnd: Date
    @Published var lastOpenDate: Date

    private let repo: FastingRepository
    private var cancellables = Set<AnyCancellable>()

    init(repo: FastingRepository) {
        self.repo = repo
        let waterInfo = (try? repo.getWaterInfo()) ?? WaterInfo()
        self.waterCups = waterInfo.waterCups
        self.reminderStart = waterInfo.reminderStart
        self.reminderEnd = waterInfo.reminderEnd
        self.lastOpenDate = waterInfo.lastOpenDate
        $reminderStart
            .receive(on: DispatchQueue.main)
            .sink { newValue in
                Task(priority: .userInitiated) {
                    try? repo.setReminderWindow(start: newValue, end: self.reminderEnd)
                }
            }
            .store(in: &cancellables)
        $reminderEnd
            .receive(on: DispatchQueue.main)
            .sink { newValue in
                Task(priority: .userInitiated) {
                    try? repo.setReminderWindow(start: self.reminderStart, end: newValue)
                }
            }
            .store(in: &cancellables)
        resetCupsIfNewDay()
    }

    func toggleCup(_ index: Int) {
        guard waterCups.indices.contains(index) else { return }
        waterCups[index].toggle()
        try? repo.toggleCup(index)
    }

    func resetCupsIfNewDay() {
        let previousOpenDate = lastOpenDate
        let openDate = Date()

        if let dayStart = mergeDates(timeFrom: reminderStart, dateFrom: openDate),
           dayStart > previousOpenDate && dayStart <= openDate {
            for i in waterCups.indices {
                waterCups[i] = false
            }
            try? repo.resetCupsToday()
        }
        printTime(date: previousOpenDate)
        if let dayStart = mergeDates(timeFrom: reminderStart, dateFrom: openDate) {
            printTime(date: dayStart)
        }
        printTime(date: openDate)
        lastOpenDate = openDate
        try? repo.setLastOpenDate()
    }

    func printTime(date: Date) {
        let calendar = Calendar.current
        let h = calendar.component(.hour, from: date)
        let m = calendar.component(.minute, from: date)
        print("\(h):\(m)")
    }

    func mergeDates(timeFrom: Date, dateFrom: Date) -> Date? {
        let calendar = Calendar.current
        let h = calendar.component(.hour, from: timeFrom)
        let m = calendar.component(.minute, from: timeFrom)
        let s = calendar.component(.second, from: timeFrom)

        let y = calendar.component(.year, from: dateFrom)
        let mo = calendar.component(.month, from: dateFrom)
        let d = calendar.component(.day, from: dateFrom)

        let comps = DateComponents(year: y, month: mo, day: d,
                                   hour: h, minute: m, second: s)
        return calendar.date(from: comps)
    }

    func enableWaterReminderNotifications() {
//        Task(priority: .userInitiated) {
//            try? repo.setReminderWindow(start: newValue, end: self.reminderEnd)
//        }
        try? repo.setReminderWindow(start: reminderStart, end: reminderEnd)
        print("\(reminderStart.hour):\(reminderStart.minute)")
        print("\(reminderEnd.hour):\(reminderEnd.minute)")
    }
}


//@Published private(set) var waterCups: [Bool] = [false,false,false,false,false,false,false,false]
//@Published private(set) var reminderStart: Date
//@Published private(set) var reminderEnd: Date
//
//waterCups: [Bool]
//reminderStart: Date
//reminderEnd: Date
