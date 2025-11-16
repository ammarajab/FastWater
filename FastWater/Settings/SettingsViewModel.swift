//
//  SettingsViewModel.swift
//  FastWater
//
//  Created by Ammar on 16/11/2025.
//

import SwiftUI
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    private let waterManager: WaterManager
    private var cancellables = Set<AnyCancellable>()
    @Published var showNotificationAlert = false

//    @Published var reminderStart: Date = Date() {
//        didSet { waterManager.reminderStart = reminderStart }
//    }

//    @Published var reminderEnd: Date = Date() {
//        didSet { waterManager.reminderEnd = reminderEnd }
//    }

    @Published var waterRemindersEnabled: Bool {
        didSet {
            if waterRemindersEnabled {
                enableReminderNotifications()
            } else {
                disableReminderNotifications()
            }
            UserDefaults.standard.set(waterRemindersEnabled, forKey: "waterReminderEnabled")
        }
    }

    init(waterManager: WaterManager) {
        let isRemindersEnabled = UserDefaults.standard.bool(forKey: "waterReminderEnabled")
        var isNotificationsAuthorized = false
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            isNotificationsAuthorized = (settings.authorizationStatus == .authorized)
        }
        self.waterRemindersEnabled = isRemindersEnabled && isNotificationsAuthorized
        self.waterManager = waterManager
//        waterManager.$reminderStart
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] new in
//                guard self?.reminderStart != new else { return }
//                self?.reminderStart = new
//            }
//            .store(in: &cancellables)
//        waterManager.$reminderEnd
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] new in
//                guard self?.reminderEnd != new else { return }
//                self?.reminderEnd = new
//            }
//            .store(in: &cancellables)
    }

    func updateValues() {
        let isRemindersEnabled = UserDefaults.standard.bool(forKey: "waterReminderEnabled")
        var isNotificationsAuthorized = false
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            isNotificationsAuthorized = (settings.authorizationStatus == .authorized)
            DispatchQueue.main.async {
                self.waterRemindersEnabled = isRemindersEnabled && isNotificationsAuthorized
            }
        }
    }

//    func enableReminderNotifications() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
//            if granted {
//                self.scheduleNotifications()
//            } else {
//                DispatchQueue.main.async {
//                    self.waterRemindersEnabled = false
//                }
//            }
//        }
//    }

    func enableReminderNotifications() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {

            case .notDetermined:
                // First time: request permission
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
                    DispatchQueue.main.async {
                        if granted {
                            self.scheduleNotifications()
                        } else {
                            self.waterRemindersEnabled = false
                            self.showNotificationAlert = true
                        }
                    }
                }

            case .denied:
                // Already denied before → show alert to open settings
                DispatchQueue.main.async {
                    self.waterRemindersEnabled = false
                    self.showNotificationAlert = true
                }

            case .authorized, .provisional, .ephemeral:
                DispatchQueue.main.async {
                    self.scheduleNotifications()
                }

            @unknown default:
                break
            }
        }
    }

    func disableReminderNotifications() {
        var ids: [String] = []
        for index in 0 ..< 8 {
            ids.append("reminder\(index + 1)")
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: ids
        )
    }

    func scheduleNotifications() {
        waterManager.enableWaterReminderNotifications()
    }
}
