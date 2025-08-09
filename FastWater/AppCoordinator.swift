//
//  AppCoordinator.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI
import Combine

enum AppRoute: Hashable {
    case welcome
    case dashboard
    case settings
}

class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath
    @Published var root: AppRoute

    init() {
        UIScrollView.appearance().indicatorStyle = .white
        let isFirstLaunch = true //UserDefaults.standard.bool(forKey: "isFirstLaunch")
        self.path = NavigationPath()
        self.root = isFirstLaunch ? .welcome : .dashboard
    }

    func navigate(to route: AppRoute) {
        switch route {
        case .dashboard:
            path = NavigationPath()
            root = .dashboard
        case .settings:
            path.append(route)
        default:
            return
        }
    }

    func goBack() {
        path.removeLast()
    }

    func buildRootView() -> some View {
        Group {
            switch root {
            case .welcome:
                WelcomeView()
            case .dashboard:
                NavigationStack(path: Binding(
                    get: { self.path },
                    set: { self.path = $0 }
                )) {
                    DashboardView()
//                        .navigationDestination(for: AppRoute.self) { route in
//                            switch route {
//                            case .dashboard:
//                                DashboardView()
//                                    .navigationBarHidden(true)
//                            }
//                        }
                }
            default:
                WelcomeView()
            }
        }
    }
}
