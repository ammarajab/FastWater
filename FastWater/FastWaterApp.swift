//
//  FastWaterApp.swift
//  FastWater
//
//  Created by Ammar on 27/07/2025.
//

import SwiftUI
import FirebaseCore
import SwiftData
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .list])
    }
}

@main
struct FastWaterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.buildRootView()
                .environmentObject(coordinator)
                .modelContainer(for: [CurrentFast.self, FastsContainer.self, WaterInfo.self])
                .buttonStyle(ScaleButtonStyle())
        }
    }
}
