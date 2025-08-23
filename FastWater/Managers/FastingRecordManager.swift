//
//  FastingRecordManager.swift
//  FastWater
//
//  Created by Ammar on 21/08/2025.
//

import Foundation
import Combine

@MainActor
public final class FastingRecordManager: ObservableObject {
    @Published public private(set) var fasts: [Int: [Int: [Fast]]] = [
        2025:
            [
                7:
                    [
                        Fast(startDate: dateBefore(days: 41),
                             endDate: dateBefore(days: 40))
                    ],
                8:
                    [
                        Fast(startDate: dateBefore(days: 20),
                             endDate: dateBefore(days: 19)),
                        Fast(startDate: dateBefore(days: 18),
                             endDate: dateBefore(days: 17)),
                        Fast(startDate: dateBefore(days: 17),
                             endDate: dateBefore(days: 16)),
                        Fast(startDate: dateBefore(days: 16),
                             endDate: dateBefore(days: 15)),
                        Fast(startDate: dateBefore(days: 8),
                             endDate: dateBefore(days: 7)),
                        Fast(startDate: dateBefore(days: 5),
                             endDate: dateBefore(days: 4)),
                        Fast(startDate: dateBefore(days: 4),
                             endDate: dateBefore(days: 3))
                    ]
            ]
    ]

    func addFast(_ fast: Fast) {
        fasts[Calendar.current.component(.year, from: fast.endDate), default: [:]][Calendar.current.component(.month, from: fast.endDate), default: []].append(fast)
    }
}

public struct Fast {
    let id: UUID = UUID()
    let startDate: Date
    let endDate: Date
}

func dateBefore(days: Int = 0, hours: Int = 0) -> Date {
    return Calendar.current.date(byAdding: .day, value: -days, to:
        Calendar.current.date(byAdding: .hour, value: -hours, to: Date())!
    )!
}
