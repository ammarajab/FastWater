//
//  ProgressCircle.swift
//  FastWater
//
//  Created by Ammar on 03/08/2025.
//

import SwiftUI

struct ProgressCircle: View {
    @EnvironmentObject var fastViewModel: FastViewModel

    var sizeRatio: Double

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: min(fastViewModel.progress, 1.0))
                .stroke(AppColors.shapeCritical, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: fastViewModel.progress)
            VStack (spacing: 0){
                Spacer()
                Text(daysText())
                    .title2(size: 35)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                combinedText
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 3)
                Text(fastText())
                    .body()
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(progressText())
                    .title(color: AppColors.textCritical)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 12)
                Spacer()
            }
        }
        .frame(width: size(), height: size())
    }

    var combinedText: Text {
        Text(Texts.timePart1(hours: fastViewModel.time.hours, minutes: fastViewModel.time.minutes))
            .title2(size: 50)
        +
        Text(Texts.timePart2(seconds: fastViewModel.time.seconds))
            .title2(size: 35, color: AppColors.textMuted)
    }

    func daysText() -> String {
        if fastViewModel.time.days == 0 {
            return ""
        }
        if fastViewModel.time.days == 1 {
            return "1 day"
        }
        return "\(fastViewModel.time.days) days"
    }

    func fastText() -> String {
        fastViewModel.isFasting ? Texts.fasting : Texts.notFasting
    }

    func progressText() -> String {
        fastViewModel.isFasting ? Texts.progressFasting(progress: fastViewModel.progress) : Texts.progressNotFasting
    }

    func size() -> Double {
        2.5 * sizeRatio
    }

    struct Texts {
        static func timePart1 (hours: Int, minutes: Int) -> String {
            "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):"
        }
        static func timePart2 (seconds: Int) -> String {
            "\(String(format: "%02d", seconds))"
        }
        static let fasting = "time spent fasting..."
        static let notFasting = "since your last fast"
        static func progressFasting(progress: Double) -> String {
            "\(Int((min(progress, 1.0) * 100).rounded()))%"
        }
        static let progressNotFasting = ""
    }
}
