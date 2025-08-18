//
//  FastView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct FastView: View {
    @Binding var showFastPopup: Bool
    @EnvironmentObject var fastViewModel: FastViewModel

    var body: some View {
        VStack {
            Text( fastViewModel.isFasting ? Texts.titleFasting : Texts.titleNotFasting)
                .title()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 25)
            Spacer()
            GeometryReader { geo in
                let originalSide = UIImage(named: Images.clock)?.size.width ?? 1
                let displaySide  = geo.size.width
                let percent      = (displaySide / originalSide) * 100
                return ZStack {
                    Image(Images.clock)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                    ProgressCircle(progress: fastViewModel.progress,
                                   isFasting: fastViewModel.isFasting,
                                   sizeRatio: percent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
            Spacer()
            Button {
                if fastViewModel.isFasting {
                    showFastPopup = true
                } else {
                    fastViewModel.startFasting()
                }
            } label: {
                Text( fastViewModel.isFasting ? Texts.buttonFasting : Texts.buttonNotFasting)
                    .title2()
                    .frame(height: 70.deviceScaled())
                    .padding(.horizontal, 70)
                    .background(AppColors.buttonPrimary)
                    .cornerRadius(30)
            }
            .padding(.bottom, 30)
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
