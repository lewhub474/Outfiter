//
//  ScrollOffsetPreferenceKey.swift
//  Outfiter
//
//  Created by Macky on 7/07/25.
//

import SwiftUI

// Modifier para rastrear el desplazamiento del ScrollView
struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
