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

struct OutfitCompositionView: View {
    let images: [String]
    var onSave: () -> Void
    var onCancel: () -> Void

    @State private var items: [DraggableImage] = []

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            // Las prendas
            ForEach($items) { $item in
                AsyncImage(url: URL(string: item.name)) { phase in
                    if let image = phase.image {
                        image
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
                                    item.position = CGPoint(
                                        x: UIScreen.main.bounds.midX,
                                        y: UIScreen.main.bounds.midY
                                    )
                                }
                            }
                    } else {
                        ProgressView()
                            .frame(width: 150, height: 150)
                    }
                }
            }

            // Botones arriba
            VStack {
                HStack {
                    Button("Cancelar") {
                        onCancel()
                    }
                    .foregroundColor(.red)
                    .bold()

                    Spacer()

                    Button("Guardar Outfit") {
                        onSave()
                    }
                    .foregroundColor(.green)
                    .bold()
                }
                .padding()
                .background(Color.white.opacity(0.8)) // ✅ fondo visible
                .shadow(radius: 3)

                Spacer()
            }
        }
        .onAppear {
            items = images.map { DraggableImage(name: $0) }
        }
    }
}
