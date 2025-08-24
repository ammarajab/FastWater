//
//  WaterViewModel.swift
//  FastWater
//
//  Created by Ammar on 23/08/2025.
//

import SwiftUI
import Combine

final class WaterViewModel: ObservableObject {
    private let waterManager: WaterManager
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var waterCups: [Bool] = []
    @Published var waterReminderStart: Date = Date()
    @Published var waterReminderEnd: Date = Date()

    init(waterManager: WaterManager) {
        self.waterManager = waterManager
        waterManager.$waterCups
            .receive(on: DispatchQueue.main)
            .assign(to: &$waterCups)
        waterManager.$waterReminderStart
            .receive(on: DispatchQueue.main)
            .assign(to: &$waterReminderStart)
        waterManager.$waterReminderEnd
            .receive(on: DispatchQueue.main)
            .assign(to: &$waterReminderEnd)
    }

    var fullGlasses: Int {
        waterCups.filter { $0 }.count
    }

    var totalGlasses: Int {
        waterCups.count
    }

    var startTimeText: String {
        format(waterReminderStart)
    }

    var endTimeText: String {
        format(waterReminderEnd)
    }

    func toggleCup(_ index: Int) {
        waterManager.toggleCup(index)
    }

    private func format(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "h:mm a"
        return f.string(from: date)
    }
}
