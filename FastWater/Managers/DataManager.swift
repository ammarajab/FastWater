//
//  DataManager.swift
//  FastWater
//
//  Created by Ammar on 31/08/2025.
//

import Foundation
import SwiftData

//@Model
//final class HydrationSettings {
//    @Attribute(.unique) var id: String = "HYDRATION_SETTINGS"
//    var reminderStart: Date
//    var reminderEnd: Date
//
//    init(reminderStart: Date, reminderEnd: Date) {
//        self.reminderStart = reminderStart
//        self.reminderEnd = reminderEnd
//    }
//}
//
//@Model
//final class HydrationDay {
//    // One row per calendar day
//    @Attribute(.unique) var dayStart: Date // normalized to startOfDay
//    // Always length 8. We keep it as an array for clarity.
//    var cups: [Bool]
//
//    init(dayStart: Date, cups: [Bool] = Array(repeating: false, count: 8)) {
//        self.dayStart = dayStart.startOfDay
//        self.cups = HydrationDay.normalized(cups)
//    }
//
//    static func normalized(_ cups: [Bool]) -> [Bool] {
//        let n = 8
//        if cups.count == n { return cups }
//        if cups.count > n { return Array(cups.prefix(n)) }
//        return cups + Array(repeating: false, count: n - cups.count)
//    }
//
//    func toggleCup(at index: Int) {
//        guard (0..<8).contains(index) else { return }
//        cups[index].toggle()
//    }
//}

//@Model
//final class Fast {
//    var start: Date
//    var end: Date
//
//    init(start: Date, end: Date) {
//        self.start = start
//        self.end = end
//    }
//
//    var durationSeconds: TimeInterval { end.timeIntervalSince(start) }
//}
//
//// MARK: - Day helper
//extension Date {
//    var startOfDay: Date { Calendar.current.startOfDay(for: self) }
//}

@Model
final class CurrentFast {
    @Attribute(.unique) var key: String = "CURRENT_FAST"
    var fastingStartTime: Date?
    var fastingEndTime: Date?

    init(start: Date? = nil, end: Date? = nil) {
        self.fastingStartTime = start
        self.fastingEndTime = end
    }
}

protocol FastingRepository {
    func getCurrent() throws -> CurrentFast
    func startFast() throws
    func endFast() throws
    func deleteFast() throws
//    func allFasts() throws -> [Fast]
}

final class SwiftDataFastingRepository: FastingRepository {
    let context: ModelContext
    init(context: ModelContext) { self.context = context }

    func getCurrent() throws -> CurrentFast {
        let fd = FetchDescriptor<CurrentFast>()
        if let c = try context.fetch(fd).first {
            return c
        }
        let c = CurrentFast()
        context.insert(c)
        try context.save()
        return c
    }

    func startFast() throws {
        let c = try getCurrent()
//        guard !c.isActive else { return }
        c.fastingStartTime = Date()
        c.fastingEndTime = nil
        try context.save()
    }

    func endFast() throws {
        let c = try getCurrent()
        guard c.fastingStartTime != nil, c.fastingEndTime == nil else { return }
        let end = Date()
        c.fastingEndTime = end
        // Persist a historical record
//        context.insert(Fast(start: start, end: end))
        try context.save()
    }

    func deleteFast() throws {
        let c = try getCurrent()
        c.fastingStartTime = nil
        c.fastingEndTime = nil
        try context.save()
    }

//    func clearCurrent() throws {
//        let c = try getOrCreateCurrent()
//        c.fastingStartTime = nil
//        c.fastingEndTime = nil
//        try context.save()
//    }
//
//    func logFast(start: Date, end: Date) throws {
//        context.insert(Fast(start: start, end: end))
//        try context.save()
//    }
//
//    func allFasts() throws -> [Fast] {
//        let fd = FetchDescriptor<Fast>(sortBy: [SortDescriptor(\.start, order: .reverse)])
//        return try context.fetch(fd)
//    }
}
