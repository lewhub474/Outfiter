//
//  Untitled.swift
//  Outfiter
//
//  Created by Macky on 3/06/25.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape
    
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Image(isLandscape ? "background_landscape" : "background")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            VStack {
                content()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .onAppear {
            updateOrientation()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            updateOrientation()
        }
    }
    
    private func updateOrientation() {
        let orientation = UIDevice.current.orientation
        if orientation.isLandscape || orientation.isPortrait {
            withAnimation(.easeInOut(duration: 0.3)) {
                isLandscape = orientation.isLandscape
            }
        }
    }
}
