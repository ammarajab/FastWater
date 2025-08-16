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
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    @Published var path: NavigationPath
    @Published var root: AppRoute

    init() {
        UIScrollView.appearance().indicatorStyle = .white
        self.path = NavigationPath()
        self.root = .welcome
        setupLaunchState()
    }

    func setupLaunchState() {
        self.root = hasLaunchedBefore ? .dashboard : .welcome
    }

    func navigate(to route: AppRoute) {
        switch route {
        case .dashboard:
            hasLaunchedBefore = true
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
        return Group {
            switch root {
            case .welcome:
                WelcomeView()
            case .dashboard:
                NavigationStack(path: Binding(
                    get: { self.path },
                    set: { self.path = $0 }
                )) {
                    DashboardView()
                }
            default:
                WelcomeView()
            }
        }
    }
}
