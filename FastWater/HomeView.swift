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
    @State private var showPopup = false
    @Binding var showSettings: Bool

    let targetProgress: Double = 1.0  // How full the bar should get
    let speed: Double = 1 / 60        // How much to increment each tick
    let interval: TimeInterval = 1.0 // Speed of animation (lower is faster updates)

    var body: some View {
        ZStack {
            Color(hex: "081325")
                .ignoresSafeArea()
            VStack {
                HStack{
                    Spacer()
                    SettingsButtonView(showSettings: $showSettings)
                }
                Spacer()
            }
            VStack {
                Text( isFasting ? "You’re fasting!" : "Get ready to fast!")
                    .font(
                        Font.custom("Lato-BlackItalic", size: 32)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 25)
                Spacer()
                ZStack {
                    Image("HomeClock")
                    ProgressCircle(progress: progress, isFasting: isFasting)
                        .padding(.top, 44)
                }
                Spacer()
                Button {
                    if isFasting {
                        showPopup = true
                    } else {
                        startProgress()
                    }
                } label: {
                    Text( isFasting ? "END FASTING" : "START FASTING")
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
            
            if showPopup {
                // Dimmed background
                Color(hex: "081325").opacity(0.97)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showPopup = false
                    }
                // Popup
                VStack (spacing: 0){
                    Button(action: {
                        print("x")
                        showPopup = false
                    }) {
                        Image("HomePopupClose")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 12)
                    .padding(.bottom, 28)
                    Button(action: {
                        print("Save Fast")
                        showPopup = false
                        stopFasting()
                    }) {
                        HStack {
                            Spacer()
                            Image("HomePopupSave")
                            Text("Save Fast")
                                .font(
                                    Font.custom("Lato-BlackItalic", size: 32)
                                )
                                .foregroundStyle(.white)
                                .padding(.leading, 5)
                                .padding(.trailing, 20)
                            Spacer()
                        }
                        .frame(height: 140)
                        .background(Color(hex: "F96758"))
                        .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
                    }
                    Rectangle()
                        .fill(Color(hex: "081325"))
                        .frame(height: 1)
                        .padding(.horizontal, 1)
                    Button(action: {
                        print("Delete Fast")
                        showPopup = false
                        stopFasting()
                    }) {
                        HStack {
                            Spacer()
                            Image("HomePopupDelete")
                            Text("Delete Fast")
                                .font(
                                    Font.custom("Lato-BlackItalic", size: 32)
                                )
                                .foregroundStyle(.white)
                                .padding(.leading, 5)
                            Spacer()
                        }
                        .frame(height: 140)
                        .background(Color(hex: "F96758"))
                        .clipShape(RoundedCorner(radius: 25, corners: [.bottomLeft, .bottomRight]))
                    }
                    Button(action: {
                        print("Cancel")
                        showPopup = false
                    }) {
                        Text("Cancel")
                            .font(
                                Font.custom("Lato-BlackItalic", size: 32)
                            )
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.top, 50)
                }
//                .background(Color(.systemGray6))
//                .shadow(radius: 10)
                .padding(.horizontal, 15)
            }

        }
        .animation(.easeInOut, value: showPopup)
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
        isFasting.toggle()
    }

    func stopFasting() {
        timer?.invalidate()
        progress = 0.0
        isFasting.toggle()
    }
}

#Preview {
    HomeView(showSettings: .constant(false))
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
