//
//  CalendarView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ZStack {
            Color(hex: "081325")
                .ignoresSafeArea()
            Text("Calendar View")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    CalendarView()
}
