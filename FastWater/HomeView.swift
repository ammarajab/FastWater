//
//  HomeView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var progress: Double = 0.0
    @State private var isFasting: Bool = false
    @State private var timer: Timer?

    let targetProgress: Double = 1.0  // How full the bar should get
    let speed: Double = 1 / 60        // How much to increment each tick
    let interval: TimeInterval = 1.0 // Speed of animation (lower is faster updates)

    var body: some View {
        ZStack {
            Color(hex: "081325")
                .ignoresSafeArea()
            VStack {
                Text("Get ready to fast!")
                    .font(
                        Font.custom("Lato-BlackItalic", size: 32)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                ZStack {
                    Image("HomeClock")
                    ProgressCircle(progress: progress, isFasting: isFasting)
                        .padding(.top, 44)
                }
                Spacer()
                Button {
                    if isFasting {
                        stopFasting()
                    } else {
                        startProgress()
                    }
                    isFasting.toggle()
                    print("Start Fasting")
                } label: {
                    Text("START FASTING")
                        .font(
                            Font.custom("Lato-Black", size: 24)
                        )
                        .foregroundStyle(.white)
                        .frame(width: 314, height: 70)
                        .background(Color(hex: "F96758"))
                        .cornerRadius(30)
                }
                Spacer()
            }
        }
    }

    func startProgress() {
        timer?.invalidate()
        progress = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { t in
            if progress >= targetProgress {
                t.invalidate()
            } else {
                progress += speed
            }
        }
    }

    func stopFasting() {
        timer?.invalidate()
        progress = 0.0
    }
}

#Preview {
    HomeView()
}
