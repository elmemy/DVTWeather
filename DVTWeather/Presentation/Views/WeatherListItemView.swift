//
//  WeatherListItemView.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import SwiftUI

struct WeatherListItemView: View {
    let weather: Weather
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading) {
                Text(weather.day)
                    .font(.weatherCardTitle)
                    .foregroundColor(AppColor.black)
                    .lineHeight(Configuration.FontSize.weatherCardLineHeight)
                    .frame(width: Configuration.UI.dayTextWidth, alignment: .leading)
                
                Spacer()
                
                Image(weather.condition.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: Configuration.UI.iconSize,
                        height: Configuration.UI.iconSize
                    )
                    .shadow(
                        color: .black.opacity(Configuration.UI.shadowOpacity),
                        radius: Configuration.UI.shadowRadius,
                        x: Configuration.UI.shadowX,
                        y: Configuration.UI.shadowY
                    )
            }
            
            Spacer()
            
            Text("\(weather.temperature)°")
                .font(.weatherTemperature)
                .foregroundColor(AppColor.black)
                .lineHeight(Configuration.FontSize.weatherTemperatureLineHeight)
                .frame(width: Configuration.UI.temperatureTextWidth, alignment: .trailing)
        }
        .padding(.horizontal, Configuration.UI.horizontalPadding)
        .padding(.vertical, Configuration.Layout.cardVerticalPadding)
        .frame(height: Configuration.UI.cardHeight)
        .background(
            RoundedRectangle(cornerRadius: Configuration.UI.cardCornerRadius)
                .fill(AppColor.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: Configuration.UI.cardCornerRadius)
                .stroke(
                    AppColor.white.opacity(Configuration.UI.borderOpacity),
                    lineWidth: Configuration.UI.borderLineWidth
                )
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(weather.accessibilityLabel)
    }
}
