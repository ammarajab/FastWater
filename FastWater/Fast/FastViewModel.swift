//
//  FastViewModel.swift
//  FastWater
//
//  Created by Ammar on 16/08/2025.
//

import SwiftUI
import Combine

@MainActor
final class FastViewModel: ObservableObject {
    struct TimeParts { let days, hours, minutes, seconds: Int }

    @Published private(set) var time: TimeParts = .init(days: 0, hours: 0, minutes: 0, seconds: 0)
    @Published private(set) var progress: Double = 0
    @Published private(set) var playSuccessAnimation = false

    private let fastingManager: FastingManager
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    var isFasting: Bool { fastingManager.isFasting }

    private let goalSeconds: Double = 16 * 60 * 60

    init(fastingManager: FastingManager) {
        self.fastingManager = fastingManager
        recompute()
    }

    func startFasting() {
        fastingManager.startFast()
        recompute()
    }

    func saveFast()  {
        fastingManager.saveFast()
        recompute()
        showSuccessAnimation()
    }

    func deleteFast(){
        fastingManager.deleteFast()
        recompute()
    }

    private func showSuccessAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.playSuccessAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.playSuccessAnimation = false
            }
        }
    }

    func onAppear() { startTimer() }
    func onDisappear() { stopTimer() }

    private func startTimer() {
        stopTimer()
        timer = .scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.recompute()
            }
        }
        timer?.tolerance = 0.2
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func recompute() {
        let baseline = (fastingManager.isFasting ? fastingManager.startTime : fastingManager.endTime) ?? Date()
        let elapsed = max(0, Int(Date().timeIntervalSince(baseline)))
        time = Self.parts(from: elapsed)
        progress = fastingManager.isFasting ? min(1, Double(elapsed) / goalSeconds) : 0
    }

    private static func parts(from seconds: Int) -> TimeParts {
        let days = seconds / (60*60*24)
        let hours = (seconds / (60*60)) % 24
        let minutes = (seconds / 60) % 60
        let secs = seconds % 60
        return .init(days: days, hours: hours, minutes: minutes, seconds: secs)
    }
}
