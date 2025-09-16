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
    @Published public private(set) var fasts: [Int: [Int: [Fast]]]

    init(repo: FastingRepository) {
        let fasts = (try? repo.getFastsContainer().fasts) ?? []
        let groupedByYear = Dictionary(grouping: fasts) { $0.year }
        var result: [Int: [Int: [Fast]]] = [:]
        for (year, fastsInYear) in groupedByYear {
            let groupedByMonth = Dictionary(grouping: fastsInYear) { $0.month }
            result[year] = groupedByMonth
        }
        self.fasts = result
    }

//    @Published public private(set) var fasts: [Int: [Int: [Fast]]] = [
//        2025:
//            [
//                7:
//                    [
//                        Fast(startTime: dateBefore(days: 41),
//                             endTime: dateBefore(days: 40))
//                    ],
//                8:
//                    [
//                        Fast(startTime: dateBefore(days: 20),
//                             endTime: dateBefore(days: 19)),
//                        Fast(startTime: dateBefore(days: 18),
//                             endTime: dateBefore(days: 17)),
//                        Fast(startTime: dateBefore(days: 17),
//                             endTime: dateBefore(days: 16)),
//                        Fast(startTime: dateBefore(days: 16),
//                             endTime: dateBefore(days: 15)),
//                        Fast(startTime: dateBefore(days: 8),
//                             endTime: dateBefore(days: 7)),
//                        Fast(startTime: dateBefore(days: 5),
//                             endTime: dateBefore(days: 4)),
//                        Fast(startTime: dateBefore(days: 4),
//                             endTime: dateBefore(days: 3))
//                    ]
//            ]
//    ]

    func addFast(_ fast: Fast) {
        var currentMonth = fasts[fast.endTime.year]?[fast.endTime.month] ?? []
        currentMonth.append(fast)
        fasts[fast.endTime.year]?[fast.endTime.month] = currentMonth
    }
}

//public struct Fast {
//    let id: UUID = UUID()
//    let startTime: Date
//    let endTime: Date
//}

func dateBefore(days: Int = 0, hours: Int = 0) -> Date {
    return Calendar.current.date(byAdding: .day, value: -days, to:
        Calendar.current.date(byAdding: .hour, value: -hours, to: Date())!
    )!
}

func createDummyDate(day: Int = 0, start: Bool = false) -> Date {
    let calendar = Calendar.current
    var components = DateComponents()
    components.year = 2025
    components.month = 8
    components.day = day
    components.hour = start ? 7 : 23

    return calendar.date(from: components)!
}
