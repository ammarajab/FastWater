//
//  CalendarView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewModel: CalendarViewModel

    var body: some View {
        VStack {
            Text(Texts.title)
                .title()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 25)
            Text(Texts.subtitle)
                .body()
                .frame(maxWidth: .infinity, alignment: .center)
            HStack {
                Button(action: {
                    viewModel.changeMonth(by: -1)
                }) {
                    Image(Images.minus)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                Spacer()
                Text(viewModel.selectedMonthText)
                    .title2(color: AppColors.textAccent)
                Spacer()
                Button(action: {
                    viewModel.changeMonth(by: 1)
                }) {
                    Image(Images.plus)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 110)
            HStack {
                ForEach(viewModel.weekDays, id: \.self) { day in
                    Text(String(day.prefix(1)))
                        .body()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 8)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 18.deviceScaled()) {
                ForEach((1 - viewModel.firstWeekdayIndex)...viewModel.numberOfDays, id: \.self) { day in
                    if day < 1 {
                        Text("")
                    } else {
                        VStack(spacing: 0) {
                            Text("\(day)")
                                .body()
                            ZStack {
                                Circle()
                                    .fill(viewModel.colorForDay(day: day))
                                    .frame(width: 24, height: 24)
                                Circle()
                                    .fill(AppColors.shapePrimary)
                                    .frame(width: 12, height: 12)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 18.deviceScaled())
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(AppColors.backgroundSecondary)
            )
            .padding(.horizontal, 32)
            .padding(.top, 4)
            Spacer()
            if viewModel.hoursFasted > 0 {
                Text(Texts.footerTitle)
                    .body()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 8)
                Text(Texts.footerSubtitle(hours: viewModel.hoursFasted, month: viewModel.selectedMonthText))
                    .title2(size: 23, color: AppColors.textAccent)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                    .padding(.bottom, 20)
            }
            Spacer()
        }
    }

    struct Images {
        static let minus = "CalendarMonthMinus"
        static let plus = "CalendarMonthPlus"
    }

    struct Texts {
        static let title = "Calendar"
        static let subtitle = "Your Fasting history:"
        static let footerTitle = "Congratulations!"

        static func footerSubtitle(hours: Int, month: String) -> String {
            if hours == 1 {
                return "You’ve fasted over \(hours) hour in \(month) alone!"
            }
            return "You’ve fasted over \(hours) hours in \(month) alone!"
        }
    }
}
