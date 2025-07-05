//
//  ClosetCompositionView.swift
//  Outfiter
//
//  Created by Macky on 19/06/25.
//

import SwiftUI

struct DraggableImage: Identifiable {
    let id = UUID()
    let name: String
    var position: CGPoint = .zero
    var scale: CGFloat = 1.0
}

struct ClosetCompositionView: View {
    @State private var items: [DraggableImage] = [
        DraggableImage(name: "imagen1"),
        DraggableImage(name: "imagen2"),
        DraggableImage(name: "imagen3")
    ]
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ForEach($items) { $item in
                Image(item.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .scaleEffect(item.scale)
                    .position(item.position)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                item.position = value.location
                            }
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                item.scale = value
                            }
                    )
                    .onAppear {
                        if item.position == .zero {
                            item.position = CGPoint(x: UIScreen.main.bounds.midX,
                                                    y: UIScreen.main.bounds.midY)
                        }
                    }
            }
        }
    }
}
