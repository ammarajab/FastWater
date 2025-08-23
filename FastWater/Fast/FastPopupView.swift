//
//  FastPopupView.swift
//  FastWater
//
//  Created by Ammar on 17/08/2025.
//

import SwiftUI

struct FastPopupView: View {
    @Binding var showFastPopup: Bool
    @EnvironmentObject var fastViewModel: FastViewModel

    var body: some View {
        VStack (spacing: 0){
            Button(action: {
                showFastPopup = false
            }) {
                Image(Images.close)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 12)
            .padding(.bottom, 28)
            Button(action: {
                showFastPopup = false
                fastViewModel.saveFast()
            }) {
                HStack {
                    Spacer()
                    Image(Images.save)
                    Text(Texts.save)
                        .title()
                        .padding(.leading, 5)
                        .padding(.trailing, 20)
                    Spacer()
                }
                .frame(height: 140)
                .background(AppColors.backgroundCritical)
                .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
            }
            Rectangle()
                .fill(AppColors.shapePrimary)
                .frame(height: 1)
                .padding(.horizontal, 1)
            Button(action: {
                showFastPopup = false
                fastViewModel.deleteFast()
            }) {
                HStack {
                    Spacer()
                    Image(Images.delete)
                    Text(Texts.delete)
                        .title()
                        .padding(.leading, 5)
                    Spacer()
                }
                .frame(height: 140)
                .background(AppColors.backgroundCritical)
                .clipShape(RoundedCorner(radius: 25, corners: [.bottomLeft, .bottomRight]))
            }
            Button(action: {
                showFastPopup = false
            }) {
                Text(Texts.cancel)
                    .title()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.top, 50)
        }
        .padding(.horizontal, 15)
    }

    struct Images {
        static let close = "FastPopupClose"
        static let save = "FastPopupSave"
        static let delete = "FastPopupDelete"
    }

    struct Texts {
        static let save = "Save Fast"
        static let delete = "Delete Fast"
        static let cancel = "Cancel"
    }
}
