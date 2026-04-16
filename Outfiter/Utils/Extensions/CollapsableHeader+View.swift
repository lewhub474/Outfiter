//
//  CollapsableHeader+View.swift
//  Outfiter
//
//  Created by Macky on 7/07/25.
//
import SwiftUI

extension View {
    func trackOffset(completion: @escaping (CGPoint) -> Void, coordinatorSpace: String) -> some View {
        self.background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self,
                                value: geo.frame(in: .named(coordinatorSpace)).minY)
            }
        )
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { y in
            completion(CGPoint(x: 0, y: y))
        }
    }
}
