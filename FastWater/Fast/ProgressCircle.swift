//
//  ProgressCircle.swift
//  FastWater
//
//  Created by Ammar on 03/08/2025.
//

import SwiftUI

struct ProgressCircle: View {
    var progress: Double
    var isFasting: Bool
    var sizeRatio: Double

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(AppColors.shapeCritical, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)
            VStack (spacing: 0){
                Spacer()
                Text(daysText())
                    .title2(size: 35)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                Text(Texts.time)
                    .title2(size: 55)
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

    func daysText() -> String {
        isFasting ? Texts.daysFasting : Texts.daysNotFasting
    }

    func fastText() -> String {
        isFasting ? Texts.fasting : Texts.notFasting
    }

    func progressText() -> String {
        isFasting ? Texts.progressFasting(progress: progress) : Texts.progressNotFasting
    }

    func size() -> Double {
        2.5 * sizeRatio
    }

    struct Texts {
        static let daysFasting = ""
        static let daysNotFasting = "2 days"
        static let time = "8:12:10"
        static let fasting = "time spent fasting..."
        static let notFasting = "since your last fast"
        static func progressFasting(progress: Double) -> String {
            "\(Int(progress * 100))%"
        }
        static let progressNotFasting = ""
    }
}
