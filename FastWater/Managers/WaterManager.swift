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
    @Published private(set) var waterCups: [Bool] = [false,false,false,false,false,false,false,false]
    @Published private(set) var waterReminderStart: Date = {
        var comps = DateComponents()
        comps.hour = 7
        comps.minute = 0
        return Calendar.current.date(from: comps) ?? Date()
    }()
    @Published private(set) var waterReminderEnd: Date = {
        var comps = DateComponents()
        comps.hour = 21
        comps.minute = 0
        return Calendar.current.date(from: comps) ?? Date()
    }()

    func toggleCup(_ index: Int) {
        guard waterCups.indices.contains(index) else { return }
        waterCups[index].toggle()
    }

    func resetCups() {
        for i in waterCups.indices {
            waterCups[i] = false
        }
    }
}
