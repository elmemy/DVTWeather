//
//  View+Extensions.swift
//  DVTWeather
//
//  Created by Elmemy on 04/11/2025.
//

import SwiftUI

extension View {
    func lineHeight(_ lineHeight: CGFloat) -> some View {
        self.modifier(LineHeightModifier(lineHeight: lineHeight))
    }
}

struct LineHeightModifier: ViewModifier {
    let lineHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .lineSpacing(lineHeight - UIFont.preferredFont(forTextStyle: .body).lineHeight)
            .padding(.vertical, (lineHeight - UIFont.preferredFont(forTextStyle: .body).lineHeight) / 2)
    }
}
