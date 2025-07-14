//
//  SelectableClothingCard.swift
//  Outfiter
//
//  Created by Macky on 11/07/25.
//

import SwiftUI

struct SelectableClothingCard: View {
    let garment: Garments
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                // Imagen principal
                AsyncImage(url: URL(string: garment.imgURL ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 240)
                            .clipped()
                    default:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 180, height: 240)
                    }
                }

                // Nombre en la parte inferior
                HStack {
                    Text(garment.name ?? "Sin nombre")
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.6)
                        .multilineTextAlignment(.leading)

                    Spacer()
                }
                .padding(8)
                .frame(width: 180)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.6), .clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 60),
                    alignment: .bottom
                )
            }

            // Checkbox en la esquina superior derecha (ahora solo visual)
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .orange : .white)
                .font(.title2)
                .padding(8)
//                .background(Circle().fill(Color.black.opacity(0.6)))
                .padding(8)
        }
        .frame(width: 180, height: 240)
        .cornerRadius(8)
        .shadow(radius: 2)
        .clipped()
        .onTapGesture {
            onTap() // 👉 Detecta el toque en toda la tarjeta
        }
    }
}
