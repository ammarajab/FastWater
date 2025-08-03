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

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(Color(hex: "F96758"), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)
            VStack (spacing: 0){
                Spacer()
                Text(daysText())
                    .font(
                        Font.custom("Lato-Black", size: 35)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)
                Text("8:12:10")
                    .font(
                        Font.custom("Lato-Black", size: 55)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 3)
                Text(fastText())
                    .font(
                        Font.custom("Lato-Regular", size: 16)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(progressText())
                    .font(
                        Font.custom("Lato-BlackItalic", size: 32)
                    )
                    .foregroundStyle(Color(hex: "F96758"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 12)
                Spacer()
            }
        }
        .frame(width: 250, height: 250)
    }

    func daysText() -> String {
        isFasting ? "" : "2 days"
    }

    func fastText() -> String {
        isFasting ? "time spent fasting..." : "since your last fast"
    }

    func progressText() -> String {
        isFasting ? "\(Int(progress * 100))%" : ""
    }
}
