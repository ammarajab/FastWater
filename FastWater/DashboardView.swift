//
//  DashboardView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct DashboardView: View {
    enum Tab: String {
        case home, calendar, water
    }
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .calendar:
                    CalendarView()
                case .water:
                    WaterView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack {
                tabBarItem(tab: .home, imageName: "HomeTabBar")
                tabBarItem(tab: .calendar, imageName: "CalendarTabBar")
                tabBarItem(tab: .water, imageName: "WaterTabBar")
            }
            .frame(height: 150)
            .background(Color(hex: "1B232F"))
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    @ViewBuilder
    private func tabBarItem(tab: Tab, imageName: String) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            ZStack {
                if selectedTab == tab {
                    Rectangle()
                        .fill(Color(hex: "081325"))
                        .frame(width: 150, height: 150)
                }
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 108, height: 108)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
