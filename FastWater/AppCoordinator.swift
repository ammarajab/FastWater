//
//  AppCoordinator.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI
import Combine
import FirebaseCore
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import GoogleSignIn
import UIKit
import Security

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
//        Task {
//            await authManager.ensureSignedInAnonymously()
//        }
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


@MainActor
final class AuthManager: ObservableObject {
    @Published var user: User?
    private var currentNonce: String?
    private var authListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        authListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.user = user
        }
    }

    deinit {
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

//    func ensureSignedInAnonymously() async {
//        if Auth.auth().currentUser == nil {
//            do {
//                let result = try await Auth.auth().signInAnonymously()
//                print("✅ Signed in anonymously with uid:", result.user.uid)
//            } catch {
//                print("❌ Failed to sign in anonymously:", error.localizedDescription)
//            }
//        }
//    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            print("✅ Signed out successfully")
        } catch {
            print("❌ Error signing out:", error.localizedDescription)
        }
    }

    // MARK: - Apple

    func prepareAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        currentNonce = nonce
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
    }

    func handleAppleSignIn(result: Result<ASAuthorization, Error>) async throws {
        switch result {
        case .success(let authorization):
            try await completeAppleSignIn(authorization: authorization)
        case .failure(let error):
            throw error
        }
    }

    private func completeAppleSignIn(authorization: ASAuthorization) async throws {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            throw NSError(domain: "auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to read Apple ID credentials."])
        }

        guard let nonce = currentNonce else {
            throw NSError(domain: "auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing login request nonce."])
        }

        guard let appleIDToken = appleIDCredential.identityToken,
              let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            throw NSError(domain: "auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to fetch identity token."])
        }

        let credential = OAuthProvider.appleCredential(
            withIDToken: idTokenString,
            rawNonce: nonce,
            fullName: appleIDCredential.fullName
        )

        let authResult = try await Auth.auth().signIn(with: credential)
        self.user = authResult.user
        currentNonce = nil
    }

    // MARK: - Google

    func signInWithGoogle() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw NSError(domain: "auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing Google client ID."])
        }

        guard let topController = rootViewController() else {
            throw NSError(domain: "auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No active window to present Google Sign-In."])
        }

        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: topController)

        guard let idToken = result.user.idToken?.tokenString else {
            throw NSError(domain: "auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to fetch Google ID token."])
        }

        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: result.user.accessToken.tokenString
        )

        let authResult = try await Auth.auth().signIn(with: credential)
        self.user = authResult.user
    }

    private func rootViewController() -> UIViewController? {
        let scenes = UIApplication.shared.connectedScenes
        return scenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })?.rootViewController
    }

    // MARK: - Nonce helpers

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        return String(nonce)
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
}
