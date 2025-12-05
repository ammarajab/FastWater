//
//  FastView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI
import DotLottie
import FirebaseAuth

struct FastView: View {
    @Binding var showFastPopup: Bool
    @Binding var showLoginPopup: Bool
    @EnvironmentObject var fastViewModel: FastViewModel
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        ZStack {
            VStack {
                Text( fastViewModel.isFasting ? Texts.titleFasting : Texts.titleNotFasting)
                    .title()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 25)
                    .padding(.bottom, 30.deviceScaled())
                Spacer()
                GeometryReader { geo in
                    let originalSide = UIImage(named: Images.clock)?.size.width ?? 1
                    let displaySide  = geo.size.width
                    let percent      = (displaySide / originalSide) * 100
                    ZStack {
                        Image(Images.clock)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                        ProgressCircle(sizeRatio: percent)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
                Spacer()
                Button {
                    handlePrimaryAction()
                } label: {
                    Text( fastViewModel.isFasting ? Texts.buttonFasting : Texts.buttonNotFasting)
                        .title2()
                        .frame(height: 70.deviceScaled())
                        .padding(.horizontal, 70)
                        .background(AppColors.buttonPrimary)
                        .cornerRadius(30)
                }
                .padding(.bottom, 70.deviceScaled())
                Spacer()
            }
            if fastViewModel.playSuccessAnimation {
                DotLottieAnimation(fileName: "Congratulations", config: AnimationConfig(autoplay: true, loop: false)).view()
            }
        }
        .onAppear { fastViewModel.onAppear() }
        .onDisappear { fastViewModel.onDisappear() }
//        .sheet(isPresented: $showLoginSheet) {
//            FastLoginSheet(isPresented: $showLoginSheet) {
//                fastViewModel.startFasting()
//            }
//            .environmentObject(authManager)
//        }
    }

    private func handlePrimaryAction() {
        if fastViewModel.isFasting {
            showFastPopup = true
//        } else if authManager.user == nil || authManager.user?.isAnonymous == true {
        } else if authManager.user == nil {
            showLoginPopup = true
        } else {
            fastViewModel.startFasting()
        }
    }

    struct Images {
        static let clock = "FastClock"
    }

    struct Texts {
        static let titleFasting = "You’re fasting!"
        static let titleNotFasting = "Get ready to fast!"
        static let buttonFasting = "END FASTING"
        static let buttonNotFasting = "START FASTING"
    }
}
