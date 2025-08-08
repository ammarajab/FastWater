//
//  WaterView.swift
//  FastWater
//
//  Created by Ammar on 31/07/2025.
//

import SwiftUI

struct WaterView: View {
    @State private var cupStates = Array(repeating: false, count: 8)
    private let columns = Array(repeating: GridItem(.fixed(125), spacing: 0), count: 2)
    @State private var startTime: Date = {
        var comps = DateComponents()
        comps.hour = 7
        comps.minute = 0
        return Calendar.current.date(from: comps) ?? Date()
    }()
    @State private var endTime: Date = {
        var comps = DateComponents()
        comps.hour = 21
        comps.minute = 0
        return Calendar.current.date(from: comps) ?? Date()
    }()
    @State private var activePicker: PickerType? = nil

    enum PickerType {
        case start, end
    }

    var body: some View {
        ZStack {
            Color(hex: "081325")
                .ignoresSafeArea()
            VStack {
                SettingsButtonView()
                Spacer()
            }
            VStack {
                Text("You’ve had 3 glasses\nof water today!")
                    .font(
                        Font.custom("Lato-BlackItalic", size: 32)
                    )
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 25)
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(0..<cupStates.count, id: \.self) { index in
                        Image(cupStates[index] ? "WaterFull" : "WaterEmpty")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 125, height: 125)
                            .clipped()
                            .transition(.moveUp)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    cupStates[index].toggle()
                                }
                            }
                    }
                }
                Spacer()
                Text("We will send 8 hydration reminders between")
                    .font(
                        Font.custom("Lato-Regular", size: 16)
                    )
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                TimeRangeView(
                    startTime: $startTime,
                    endTime: $endTime,
                    onStartTap: { activePicker = .start },
                    onEndTap: { activePicker = .end }
                )
            }
            .padding(.vertical, 10)
        }
        .overlay(
            Group {
                if let type = activePicker {
                    DimmedBackground {
                        activePicker = nil
                    }

                    PickerPopup(
                        title: type == .start ? "Start Time" : "End Time",
                        selection: type == .start ? $startTime : $endTime
                    )
                }
            }
        )
    }
}

#Preview {
    WaterView()
}

extension AnyTransition {
    static var moveUp: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .opacity
        )
    }
}

struct TimeRangeView: View {
    @Binding var startTime: Date
    @Binding var endTime: Date
    var onStartTap: () -> Void
    var onEndTap: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Button {
                onStartTap()
            } label: {
                Text(format(startTime))
                    .font(
                        Font.custom("Lato-Black", size: 25)
                    )
                    .foregroundStyle(Color(hex: "F0C17E"))
                    .underline()
            }
            Text("     and     ")
                .font(
                    Font.custom("Lato-Regular", size: 16)
                )
                .foregroundStyle(.white)
            Button {
                onEndTap()
            } label: {
                Text(format(endTime))
                    .font(
                        Font.custom("Lato-Black", size: 25)
                    )
                    .foregroundStyle(Color(hex: "F0C17E"))
                    .underline()
            }
            Spacer()
        }
        .padding()
    }

    func format(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "h:mm a"
        return f.string(from: date)
    }
}

struct PickerPopup: View {
    let title: String
    @Binding var selection: Date

    var body: some View {
        DatePicker(
            "",
            selection: $selection,
            displayedComponents: .hourAndMinute
        )
        .datePickerStyle(.wheel)
        .labelsHidden()
        .colorScheme(.dark)
        .frame(height: 150)
        .padding()
        .background(Color(hex: "081325"))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        .frame(maxWidth: 300)
        .transition(.scale)
        .zIndex(1)
    }
}

struct DimmedBackground: View {
    var tapToDismiss: () -> Void

    var body: some View {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
            .onTapGesture {
                tapToDismiss()
            }
            .zIndex(0)
//        ZStack {
//            VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
//                .ignoresSafeArea()
//            Color.black.opacity(0.3)
//                .ignoresSafeArea()
//        }
//        .onTapGesture {
//            tapToDismiss()
//        }
//        .zIndex(0)
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
