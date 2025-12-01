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
    private let repo: FastingRepository = FirebaseFastingRepository()

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
//        try await repo.setReminderWindow(start: start, end: end)
        updateNotifications(start: start, end: end)
    }

    func updateNotifications(start: Date, end: Date) {
        Task {
            let granted = await NotificationManager.requestAuthorization()
            guard granted else {
                print("⚠️ Notifications not allowed by the user")
                return
            }

            await NotificationManager.scheduleDailyReminders(
                start: start,
                end: end
            )
        }
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

import FirebaseAuth
import FirebaseFirestore

final class FirebaseFastingRepository: FastingRepository {
    func getCurrentFast() throws -> CurrentFast {
        CurrentFast()
    }

    func getFastsContainer() throws -> FastsContainer {
        FastsContainer()
    }

    func getWaterInfo() throws -> WaterInfo {
        WaterInfo()
    }

    func startFast() throws {
        
    }

    func endFast() throws {
        
    }

    func deleteFast() throws {
        
    }

    func setReminderWindow(start: Date, end: Date) throws {
        guard let uid = Auth.auth().currentUser?.uid else { throw NSError(domain: "auth", code: 401) }
        let start = minutesSinceMidnight(from: start)
        let end   = minutesSinceMidnight(from: end)
        let tzID = TimeZone.current.identifier

        let data: [String: Any] = [
            "startMinutes": start,
            "endMinutes": end,
            "tz": tzID,
            "updatedAt": FieldValue.serverTimestamp()
        ]

        Task {
            do {
                try await Firestore.firestore()
                    .collection("users").document(uid)
                    .collection("settings").document("reminders")
                    .setData(data, merge: true)
                print("✅ Saved reminder prefs successfully")
            } catch {
                print("❌ Failed to save reminder prefs:", error.localizedDescription)
            }
        }
    }

    func toggleCup(_ index: Int) throws {
        
    }

    func resetCupsToday() throws {
        
    }

    func setLastOpenDate() throws {
        
    }

//    func minutesSinceMidnight(hour: Int, minute: Int) -> Int {
//        max(0, min(23 * 60 + 59, hour * 60 + minute))
//    }

    func timeComponents(from minutes: Int, timeZone: TimeZone) -> DateComponents {
        let clamped = max(0, min(23*60+59, minutes))
        return DateComponents(timeZone: timeZone, hour: clamped / 60, minute: clamped % 60)
    }

    func minutesSinceMidnight(from date: Date) -> Int {
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.hour, .minute], from: date)
        let hours = comps.hour ?? 0
        let minutes = comps.minute ?? 0
        return hours * 60 + minutes
    }
}

import UserNotifications

enum NotificationManager {
    static func requestAuthorization() async -> Bool {
        let center = UNUserNotificationCenter.current()
        do {
            let granted = try await center.requestAuthorization(
                options: [.alert, .sound, .badge]
            )
            UserDefaults.standard.set(true, forKey: "waterReminderEnabled")
            return granted
        } catch {
            print("❌ Notification auth error:", error.localizedDescription)
            UserDefaults.standard.set(false, forKey: "waterReminderEnabled")
            return false
        }
    }
}

extension NotificationManager {
    static func scheduleDailyReminders(start: Date, end: Date, title: String = "Water reminder") async {
        let center = UNUserNotificationCenter.current()
        var ids: [String] = []
        for index in 0 ..< 8 {
            ids.append("reminder\(index + 1)")
        }
        center.removePendingNotificationRequests(withIdentifiers: ids)
        let rawInterval = end.timeIntervalSince(start)
        let totalInterval = rawInterval > 0 ? rawInterval : rawInterval + 86400
        let step = totalInterval / 7
        print("reminders totalInterval \(totalInterval)")
        print("reminders step \(step)")
        for index in 0 ..< 8 {
            guard index < ids.count else { break }
            let reminderId = ids[index]
            let reminderTime = start.addingTimeInterval(step * Double(index))
            let request = makeRequest(
                identifier: reminderId,
                time: reminderTime,
                title: title,
                body: "It's time to have a glass of water.",
                repeats: true
            )
            do {
                try await center.add(request)
            } catch {
                print("adding requests failed:", error)
            }
            print("reminder\(index + 1)")
            print("reminders time \(reminderTime)")
            print("reminders time \(reminderTime.hour):\(reminderTime.minute)")
        }
        print("✅ Scheduled start/end reminders at \(start.hour):\(start.minute) / \(end.hour):\(end.minute) minutes since midnight")
    }

    static func scheduleFastEndReminder(startTime: Date) async {
        let title = "Fast Complete"
        let center = UNUserNotificationCenter.current()
        var reminderId = "fastComplete"
        center.removePendingNotificationRequests(withIdentifiers: [reminderId])
        let reminderTime = startTime.addingTimeInterval(57600)
        let request = makeRequest(
            identifier: reminderId,
            time: reminderTime,
            title: title,
            body: "Congratulations you have fasted for 16 hours.",
            repeats: false
        )
        do {
            try await center.add(request)
        } catch {
            print("adding requests failed:", error)
        }
    }

    static func removeFastEndreminder() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["fastComplete"])
    }

    private static func makeRequest(identifier: String,
                                    time: Date,
                                    title: String,
                                    body: String,
                                    repeats: Bool) -> UNNotificationRequest {
        var comps = DateComponents()
        comps.hour = time.hour
        comps.minute = time.minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: repeats)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        return UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }

    @discardableResult
    static func add(_ request: UNNotificationRequest) async -> Bool {
        await withCheckedContinuation { cont in
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("❌ Scheduling error for \(request.identifier):", error.localizedDescription)
                    cont.resume(returning: false)
                } else {
                    cont.resume(returning: true)
                }
            }
        }
    }
}
