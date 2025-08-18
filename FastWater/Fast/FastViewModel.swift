//
//  FastViewModel.swift
//  FastWater
//
//  Created by Ammar on 16/08/2025.
//

import SwiftUI
import Combine

final class FastViewModel: ObservableObject {
    @Published var isFasting = false
    @Published var progress: Double = 0.0
    private var timer: Timer?
    let targetProgress: Double = 1.0  // How full the bar should get
    let speed: Double = 1 / 60        // How much to increment each tick
    let interval: TimeInterval = 1.0 // Speed of animation (lower is faster updates)

    func startFasting() {
        timer?.invalidate()
        progress = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] t in
            guard let self else { return }
            if progress >= targetProgress {
                t.invalidate()
            } else {
                progress += speed
            }
        }
        isFasting.toggle()
    }

    func stopFasting() {
        timer?.invalidate()
        progress = 0.0
        isFasting.toggle()
    }
}
