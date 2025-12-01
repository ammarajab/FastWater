//
//  FastingManager.swift
//  FastWater
//
//  Created by Ammar on 19/08/2025.
//

import Foundation
import Combine

@MainActor
public final class FastingManager: ObservableObject {
    private let fastingRecordManager: FastingRecordManager
    @Published public private(set) var isFasting: Bool // = false
    @Published public private(set) var startTime: Date?
    @Published public private(set) var endTime: Date? // = Date().addingTimeInterval(-72 * 60 * 60)
    private let repo: FastingRepository

    init(fastingRecordManager: FastingRecordManager,
         repo: FastingRepository) {
        self.fastingRecordManager = fastingRecordManager
        self.repo = repo
        let currentFast = try? repo.getCurrentFast()
        startTime = currentFast?.startTime
        endTime = currentFast?.endTime
        isFasting = (currentFast?.startTime != nil) && (currentFast?.endTime == nil)
    }

    public func startFast() {
        isFasting = true
        startTime = Date()
        try? repo.startFast()
        updateNotifications(startTime: startTime)
    }

    private func updateNotifications(startTime: Date?) {
        Task {
            let granted = await NotificationManager.requestAuthorization()
            guard granted,
            let startTime else {
                print("⚠️ Notifications not allowed by the user")
                return
            }
            await NotificationManager.scheduleFastEndReminder(startTime: startTime)
        }
    }

    public func saveFast() {
        guard isFasting else { return }
        isFasting = false
        endTime = Date()
        if let startTime,
           let endTime {
            fastingRecordManager.addFast(Fast(startTime: startTime, endTime: endTime))
        }        
        try? repo.endFast()
        removeNotifications()
    }

    public func deleteFast() {
        isFasting = false
        try? repo.deleteFast()
        removeNotifications()
    }

    private func removeNotifications() {
        Task {
            let granted = await NotificationManager.requestAuthorization()
            guard granted else {
                print("⚠️ Notifications not allowed by the user")
                return
            }
            NotificationManager.removeFastEndreminder()
        }
    }
}
