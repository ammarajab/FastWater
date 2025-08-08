//
//  CalendarView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    let calendar = Calendar.current

    var body: some View {
        let monthMetadata = generateMonthMetadata(for: currentDate)

        ZStack {
            Color(hex: "081325")
                .ignoresSafeArea()
            VStack {
                HStack{
                    Spacer()
                    SettingsButtonView()
                }
                Spacer()
            }
            VStack {
                Text("Calendar")
                    .font(
                        Font.custom("Lato-BlackItalic", size: 32)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Your Fasting history:")
                    .font(
                        Font.custom("Lato-Regular", size: 16)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                HStack(spacing: 26) {
                    Button(action: {
                        changeMonth(by: -1)
                    }) {
                        Image("CalendarMonthMinus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    Text(monthMetadata.monthName)
                        .font(
                            Font.custom("Lato-Black", size: 25)
                        )
                        .foregroundStyle(Color(hex: "F0C17E"))
                    Button(action: {
                        changeMonth(by: 1)
                    }) {
                        Image("CalendarMonthPlus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(.top, 8)
                HStack {
                    ForEach(calendar.shortWeekdaySymbols, id: \.self) { day in
                        Text(String(day.prefix(1)))
                            .font(
                                Font.custom("Lato-Regular", size: 16)
                            )
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.top, 8)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 21) {
                    ForEach((1 - monthMetadata.firstWeekdayIndex)...monthMetadata.numberOfDays, id: \.self) { day in
                        if day < 1 {
                            Text("")
                        } else {
                            VStack(spacing: 0) {
                                Text("\(day)")
                                    .font(
                                        Font.custom("Lato-Regular", size: 16)
                                    )
                                    .foregroundStyle(.white)
                                ZStack {
                                    Circle()
                                        .fill(colorForDay(day: day))
                                        .frame(width: 28, height: 28)
                                    Circle()
                                        .fill(Color(hex: "081325"))
                                        .frame(width: 14, height: 14)
                                }
                            }
                        }
                    }
                }
                .padding(18)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(hex: "121F33"))
                )
                .padding(.horizontal, 22)
                .padding(.top, 6)
                Text("Congratulations!")
                    .font(
                        Font.custom("Lato-Regular", size: 16)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 8)
                Text("You’ve fasted over 265 hours in June alone!")
                    .font(
                        Font.custom("Lato-Black", size: 25)
                    )
                    .foregroundStyle(Color(hex: "F0C17E"))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                Spacer()
            }
            .padding(.top, 25)
        }
    }

    func changeMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
        }
    }

    func colorForDay(day: Int) -> Color {
        if day % 2 == 0 {
            return Color(hex: "F96758")
        } else {
            return Color(hex: "585858")
        }
    }

    func generateMonthMetadata(for date: Date) -> (yearName: String, monthName: String, numberOfDays: Int, firstWeekdayIndex: Int) {
        let components = calendar.dateComponents([.year, .month], from: date)
        let firstOfMonth = calendar.date(from: components)!
        let range = calendar.range(of: .day, in: .month, for: firstOfMonth)!
        let numberOfDays = range.count
        let weekday = calendar.component(.weekday, from: firstOfMonth)
        let yearName = " \(components.year!)"
        let monthName = DateFormatter().monthSymbols[components.month! - 1]
        print("firstWeekdayIndex \(weekday - 1)")
        return (yearName, monthName, numberOfDays, weekday - 1)
    }
}

#Preview {
    CalendarView()
}
