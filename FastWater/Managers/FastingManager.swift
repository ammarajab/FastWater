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
    @Published public private(set) var isFasting = false
    @Published public private(set) var fastingStartTime: Date?
    @Published public private(set) var fastingEndTime: Date? = Date().addingTimeInterval(-50 * 60 * 60)

    init(fastingRecordManager: FastingRecordManager) {
        self.fastingRecordManager = fastingRecordManager
    }

    public func startFast() {
        isFasting = true
        fastingStartTime = Date()
    }

    public func saveFast() {
        guard isFasting else { return }
        isFasting = false
        fastingEndTime = Date()
        if let fastingStartTime,
           let fastingEndTime {
            fastingRecordManager.addFast(Fast(startDate: fastingStartTime, endDate: fastingEndTime))
        }
    }

    public func deleteFast() {
        isFasting = false
    }
}
