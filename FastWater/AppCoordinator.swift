//
//  AppCoordinator.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI
import Combine
import FirebaseAuth

enum AppRoute: Hashable {
    case welcome
    case dashboard
    case settings
}

@MainActor
class AppCoordinator: ObservableObject {
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    @Published var path: NavigationPath
    @Published var root: AppRoute
    @Published var authManager = AuthManager()

    init() {
        UIScrollView.appearance().indicatorStyle = .white
        self.path = NavigationPath()
        self.root = .welcome
        setupLaunchState()
        Task {
            await authManager.ensureSignedInAnonymously()
        }
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

//    func ensureSignedInAnonymously() async throws {
//      if Auth.auth().currentUser == nil {
//        _ = try await Auth.auth().signInAnonymously()
//      }
//    }

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


@MainActor
final class AuthManager: ObservableObject {
    @Published var user: User?

    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.user = user
        }
    }

    func ensureSignedInAnonymously() async {
        if Auth.auth().currentUser == nil {
            do {
                let result = try await Auth.auth().signInAnonymously()
                print("✅ Signed in anonymously with uid:", result.user.uid)
            } catch {
                print("❌ Failed to sign in anonymously:", error.localizedDescription)
            }
        }
    }

//    func signOut() {
//        do {
//            try Auth.auth().signOut()
//            print("✅ Signed out successfully")
//        } catch {
//            print("❌ Error signing out:", error.localizedDescription)
//        }
//    }
}
