//
//  EmptyView.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//
import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack(spacing: Configuration.Layout.cardContentSpacing) {
            Image("02.sunset-light")
                .resizable()
                .frame(width: Configuration.UI.smallIconSize, height: Configuration.UI.smallIconSize)
            
            Text(LocalizedString.noWeatherData)
                .font(.poppins(.bold(size: Configuration.FontSize.largeTitle)))
                .foregroundColor(AppColor.white)
            
            Text(LocalizedString.pullToRefresh)
                .font(.poppins(.medium(size: Configuration.FontSize.subtitle)))
                .foregroundColor(AppColor.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, Configuration.Layout.errorHorizontalPadding)
        }
    }
}
