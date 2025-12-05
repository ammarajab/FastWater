//
//  FastLoginView.swift
//  FastWater
//
//  Created by Ammar on 02/12/2025.
//

import SwiftUI
import AuthenticationServices
import GoogleSignInSwift

struct FastLoginView: View {
    @Binding var showLoginPopup: Bool
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var fastViewModel: FastViewModel
    @State private var isSigningIn = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack (spacing: 0){
                Image("LoginPopupHeader")
                Text("Sign up or Log in:")
                    .title()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 50)
                if let errorMessage {
                    Text(errorMessage)
                        .body(color: .white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                SignInWithAppleButton(.signIn, onRequest: { request in
                    authManager.prepareAppleRequest(request)
                }, onCompletion: { result in
                    Task { await handleApple(result: result) }
                })
                .signInWithAppleButtonStyle(.white)
                .frame(height: 50)
                .cornerRadius(25)
                .padding(.top, 30)
                .padding(.horizontal, 50)
                GoogleSignInButton(scheme: .light, style: .wide, state: .normal) {
                    Task { await handleGoogleSignIn() }
                }
//                .frame(height: 50)
//                .cornerRadius(10)
                .padding(.top, 30)
                .padding(.horizontal, 50)
                if isSigningIn {
                    ProgressView("Signing in...")
                        .padding(.top, 8)
                }
                Button(action: {
                    showLoginPopup = false
                }) {
                    Text("I’ll do it later")
                        .title()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.top, 50)
                .padding(.bottom, 30)
            }
//            .background(AppColors.backgroundCritical)
//            .clipShape(RoundedCorner(radius: 25))
            .background(
                AppColors.backgroundCritical
                    .clipShape(RoundedCorner(radius: 25))
                    .offset(y: 56)
                    .padding(.bottom, 56)
            )
            .padding(.horizontal, 15)
            .padding(.bottom, 150)
        }
    }

    private func handleApple(result: Result<ASAuthorization, Error>) async {
        await signIn(action: {
            try await authManager.handleAppleSignIn(result: result)
        })
    }

    private func handleGoogleSignIn() async {
        await signIn(action: {
            try await authManager.signInWithGoogle()
        })
    }

    private func signIn(action: @escaping () async throws -> Void) async {
        guard !isSigningIn else { return }
        isSigningIn = true
        errorMessage = nil
        do {
            try await action()
            showLoginPopup = false
            fastViewModel.startFasting()
        } catch {
            errorMessage = error.localizedDescription
        }

        isSigningIn = false
    }
}
