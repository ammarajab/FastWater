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

    var body: some Scene {
        WindowGroup {
            coordinator.buildRootView()
                .environmentObject(coordinator)
        }
    }
}
