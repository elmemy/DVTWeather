//
//  ErrorView.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//
import SwiftUI

struct ErrorView: View {
    let error: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: Configuration.Layout.cardContentSpacing) {
            Image("01.sun-light")
                .resizable()
                .frame(width: Configuration.UI.smallIconSize, height: Configuration.UI.smallIconSize)
            
            Text(LocalizedString.unableToLoad)
                .font(.poppins(.bold(size: Configuration.FontSize.largeTitle)))
                .foregroundColor(AppColor.white)
            
            Text(error)
                .font(.poppins(.medium(size: Configuration.FontSize.subtitle)))
                .foregroundColor(AppColor.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Configuration.Layout.errorHorizontalPadding)
            
            Button(LocalizedString.tryAgain, action: onRetry)
                .buttonStyle(.borderedProminent)
                .tint(AppColor.white)
                .foregroundColor(AppColor.blue)
                .font(.poppins(.medium(size: Configuration.FontSize.subtitle)))
        }
    }
}
