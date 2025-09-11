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
    @Published public private(set) var fastingStartTime: Date?
    @Published public private(set) var fastingEndTime: Date? // = Date().addingTimeInterval(-72 * 60 * 60)
    private let repo: FastingRepository

    init(fastingRecordManager: FastingRecordManager,
         repo: FastingRepository) {
        self.fastingRecordManager = fastingRecordManager
        self.repo = repo
        let currentFast = try? repo.getCurrent()
        fastingStartTime = currentFast?.fastingStartTime
        fastingEndTime = currentFast?.fastingEndTime
        isFasting = (currentFast?.fastingStartTime != nil) && (currentFast?.fastingEndTime == nil)
    }

    public func startFast() {
        isFasting = true
        fastingStartTime = Date()
        try? repo.startFast()
    }

    public func saveFast() {
        guard isFasting else { return }
        isFasting = false
        fastingEndTime = Date()
        if let fastingStartTime,
           let fastingEndTime {
            fastingRecordManager.addFast(Fast(startDate: fastingStartTime, endDate: fastingEndTime))
        }
        try? repo.endFast()
    }

    public func deleteFast() {
        isFasting = false
        try? repo.deleteFast()
    }
}
