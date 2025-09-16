//
//  DataManager.swift
//  FastWater
//
//  Created by Ammar on 31/08/2025.
//

import Foundation
import SwiftData

//@Model
//final class CurrentFast {
//    @Attribute(.unique) var key: String = "CURRENT_FAST"
//    var startTime: Date?
//    var endTime: Date?
//
//    init(start: Date? = nil, end: Date? = nil) {
//        self.startTime = start
//        self.endTime = end
//    }
//}

@Model
public final class Fast {
    @Attribute var startTime: Date
    @Attribute var endTime: Date

    var year: Int {
        endTime.year
    }

    var month: Int {
        endTime.month
    }

    init(startTime: Date, endTime: Date) {
        self.startTime = startTime
        self.endTime = endTime
    }

    init?(currentFast: CurrentFast) {
        guard let startTime = currentFast.startTime,
              let endTime = currentFast.endTime else {
            return nil
        }
        self.startTime = startTime
        self.endTime = endTime
    }
}

@Model
final class CurrentFast {
    var startTime: Date?
    var endTime: Date?

    init(startTime: Date? = nil, endTime: Date? = nil) {
        self.startTime = startTime
        self.endTime = endTime
    }
}

@Model
final class FastsContainer {
    @Relationship(deleteRule: .cascade) var fasts: [Fast] = []

    init(fasts: [Fast] = []) {
        self.fasts = fasts
    }
}

@Model
final class WaterInfo {
    var waterCups: [Bool]
    var reminderStart: Date
    var reminderEnd: Date
    var lastOpenDate: Date

    init(
        waterCups: [Bool] = [false,false,false,false,false,false,false,false],
        reminderStart: Date = Calendar.current.date(from: DateComponents(hour: 7, minute: 0)) ?? Date(),
        reminderEnd: Date = Calendar.current.date(from: DateComponents(hour: 21, minute: 0)) ?? Date(),
        lastOpenDate: Date = Date()
    ) {
        self.waterCups = waterCups
        self.reminderStart = reminderStart
        self.reminderEnd = reminderEnd
        self.lastOpenDate = lastOpenDate
    }
}

protocol FastingRepository {
    func getCurrentFast() throws -> CurrentFast
    func getFastsContainer() throws -> FastsContainer
    func getWaterInfo() throws -> WaterInfo
    func startFast() throws
    func endFast() throws
    func deleteFast() throws
    func setReminderWindow(start: Date, end: Date) throws
    func toggleCup(_ index: Int) throws
    func resetCupsToday() throws
    func setLastOpenDate() throws
}

final class SwiftDataFastingRepository: FastingRepository {
    let context: ModelContext
    init(context: ModelContext) { self.context = context }

    func getCurrentFast() throws -> CurrentFast {
        let fd = FetchDescriptor<CurrentFast>()
        if let currentFast = try context.fetch(fd).first {
            return currentFast
        }
        let currentFast = CurrentFast()
        context.insert(currentFast)
        try context.save()
        return currentFast
    }

    func getFastsContainer() throws -> FastsContainer {
        let fd = FetchDescriptor<FastsContainer>()
        if let fastsContainer = try context.fetch(fd).first {
            return fastsContainer
        }
        let fastsContainer = FastsContainer(fasts: createDummyFasts())
        context.insert(fastsContainer)
        try context.save()
        return fastsContainer
    }

    func getWaterInfo() throws -> WaterInfo {
        let fd = FetchDescriptor<WaterInfo>()
        if let waterInfo = try context.fetch(fd).first {
            return waterInfo
        }
        let waterInfo = WaterInfo()
        context.insert(waterInfo)
        try context.save()
        return waterInfo
    }

    func createDummyFasts() -> [Fast] {
        [
            Fast(startTime: createDummyDate(day: 4, start: true),
                 endTime: createDummyDate(day: 4)),
            Fast(startTime: createDummyDate(day: 5, start: true),
                 endTime: createDummyDate(day: 5)),
            Fast(startTime: createDummyDate(day: 6, start: true),
                 endTime: createDummyDate(day: 6)),
            Fast(startTime: createDummyDate(day: 7, start: true),
                 endTime: createDummyDate(day: 7)),
            Fast(startTime: createDummyDate(day: 8, start: true),
                 endTime: createDummyDate(day: 8)),

            Fast(startTime: createDummyDate(day: 11, start: true),
                 endTime: createDummyDate(day: 11)),
            Fast(startTime: createDummyDate(day: 12, start: true),
                 endTime: createDummyDate(day: 12)),
            Fast(startTime: createDummyDate(day: 13, start: true),
                 endTime: createDummyDate(day: 13)),
            Fast(startTime: createDummyDate(day: 14, start: true),
                 endTime: createDummyDate(day: 14)),
            Fast(startTime: createDummyDate(day: 15, start: true),
                 endTime: createDummyDate(day: 15)),

            Fast(startTime: createDummyDate(day: 18, start: true),
                 endTime: createDummyDate(day: 18)),
            Fast(startTime: createDummyDate(day: 19, start: true),
                 endTime: createDummyDate(day: 19)),
            Fast(startTime: createDummyDate(day: 20, start: true),
                 endTime: createDummyDate(day: 20)),
            Fast(startTime: createDummyDate(day: 21, start: true),
                 endTime: createDummyDate(day: 21)),
            Fast(startTime: createDummyDate(day: 22, start: true),
                 endTime: createDummyDate(day: 22)),

            Fast(startTime: createDummyDate(day: 25, start: true),
                 endTime: createDummyDate(day: 25)),
            Fast(startTime: createDummyDate(day: 26, start: true),
                 endTime: createDummyDate(day: 26)),
            Fast(startTime: createDummyDate(day: 27, start: true),
                 endTime: createDummyDate(day: 27)),
            Fast(startTime: createDummyDate(day: 28, start: true),
                 endTime: createDummyDate(day: 28)),
            Fast(startTime: createDummyDate(day: 29, start: true),
                 endTime: createDummyDate(day: 29))
        ]
    }

    func startFast() throws {
        let currentFast = try getCurrentFast()
//        guard !c.isActive else { return }
        currentFast.startTime = Date()
        currentFast.endTime = nil
        try context.save()
    }

    func endFast() throws {
        let currentFast = try getCurrentFast()
        guard currentFast.startTime != nil, currentFast.endTime == nil else { return }
        let end = Date()
        currentFast.endTime = end
        try context.save()
        guard let fast = Fast(currentFast: currentFast) else {
            return
        }
        let fastsContainer = try getFastsContainer()
        fastsContainer.fasts.append(fast)
    }

    func deleteFast() throws {
        let currentFast = try getCurrentFast()
        currentFast.startTime = nil
        currentFast.endTime = nil
        try context.save()
    }

    func setReminderWindow(start: Date, end: Date) throws {
        let waterInfo = try getWaterInfo()
        waterInfo.reminderStart = start
        waterInfo.reminderEnd = end
        try context.save()
    }

    func toggleCup(_ index: Int) throws {
        let waterInfo = try getWaterInfo()
        guard index < waterInfo.waterCups.count else { return }
        waterInfo.waterCups[index].toggle()
        try context.save()
    }

    func resetCupsToday() throws {
        let waterInfo = try getWaterInfo()
        waterInfo.waterCups = Array(repeating: false, count: 8)
        try context.save()
    }

    func setLastOpenDate() throws {
        let waterInfo = try getWaterInfo()
        waterInfo.lastOpenDate = Date()
        try context.save()
    }
}
