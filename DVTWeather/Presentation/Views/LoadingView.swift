//
//  LoadingView.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//
import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: Configuration.Layout.cardContentSpacing) {
            ProgressView()
                .scaleEffect(Configuration.Progress.scaleEffect)
                .tint(AppColor.white)
            
            Text(LocalizedString.loadingWeather)
                .font(.poppins(.medium(size: Configuration.FontSize.title)))
                .foregroundColor(AppColor.white)
        }
    }
}
