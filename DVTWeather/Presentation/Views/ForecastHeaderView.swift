//
//  ForecastHeaderView.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//
import SwiftUI

struct ForecastHeaderView: View {
    var body: some View {
        VStack {
            Text(LocalizedString.fiveDayForecast)
                .font(.titleFont)
                .foregroundColor(AppColor.white)
                .frame(height: Configuration.Layout.forecastHeaderFrame)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, Configuration.Layout.titleTopPadding)
                .padding(.horizontal, Configuration.UI.horizontalPadding)
            
            Rectangle()
                .frame(height: Configuration.UI.dividerHeight)
                .foregroundColor(AppColor.white)
                .padding(.vertical, Configuration.UI.gridSpacing)
        }
    }
}
