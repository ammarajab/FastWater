//
//  WaterViewModel.swift
//  FastWater
//
//  Created by Ammar on 23/08/2025.
//

import SwiftUI
import Combine

@MainActor
final class WaterViewModel: ObservableObject {
    private let waterManager: WaterManager
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var waterCups: [Bool] = []
    @Published var reminderStart: Date = Date() {
        didSet { waterManager.reminderStart = reminderStart }
    }
    @Published var reminderEnd: Date = Date() {
        didSet { waterManager.reminderEnd = reminderEnd }
    }

    init(waterManager: WaterManager) {
        self.waterManager = waterManager
        waterManager.$waterCups
            .receive(on: DispatchQueue.main)
            .assign(to: &$waterCups)
        waterManager.$reminderStart
            .receive(on: DispatchQueue.main)
            .sink { [weak self] new in
                guard self?.reminderStart != new else { return }
                self?.reminderStart = new
            }
            .store(in: &cancellables)
        waterManager.$reminderEnd
            .receive(on: DispatchQueue.main)
            .sink { [weak self] new in
                guard self?.reminderEnd != new else { return }
                self?.reminderEnd = new
            }
            .store(in: &cancellables)
    }

    var fullGlasses: Int {
        waterCups.filter { $0 }.count
    }

    var totalGlasses: Int {
        waterCups.count
    }

    var startTimeText: String {
        format(reminderStart)
    }

    var endTimeText: String {
        format(reminderEnd)
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
