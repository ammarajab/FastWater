//
//  FastWaterApp.swift
//  FastWater
//
//  Created by Ammar on 27/07/2025.
//

import SwiftUI

@main
struct FastWaterApp: App {
    @StateObject var coordinator = AppCoordinator()
//    @StateObject var fastingRecordManager = FastingRecordManager()
//    @StateObject var fastingManager: FastingManager

//    init() {
//        let fastingRecordManager = FastingRecordManager()
//        _fastingRecordManager = StateObject(wrappedValue: fastingRecordManager)
//        _fastingManager = StateObject(wrappedValue: FastingManager(fastingRecordManager: fastingRecordManager))
//    }

    var body: some Scene {
        WindowGroup {
            coordinator.buildRootView()
                .environmentObject(coordinator)
//                .environmentObject(fastingManager)
//                .environmentObject(fastingRecordManager)
                .buttonStyle(ScaleButtonStyle())
        }
    }
}
