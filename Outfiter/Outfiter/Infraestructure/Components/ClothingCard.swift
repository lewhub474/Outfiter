//
//  ClothingCard.swift
//  Outfiter
//
//  Created by Macky on 3/06/25.
//

import SwiftUI

struct ClothingCard: View {
    let garment: Garments
    @EnvironmentObject var viewModel: ClosetViewModel  // Accede al ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: "https://gw.alicdn.com/imgextra/O1CN01lh9Qo51JUFAR4BLqW_!!6000000001031-0-yinhe.jpg"))
            { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 160, height: 160)
                        .clipped()
                        .cornerRadius(12)
                default:
                    Rectangle()
                        .fill(SwiftUI.Color.gray.opacity(0.3))
                        .frame(width: 160, height: 160)
                        .cornerRadius(12)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(garment.name ?? "Sin nombre")
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .minimumScaleFactor(0.8)

                Text("Categoría: \(garment.category?.category ?? "Desconocida")")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.9))

                Text("Color: \(garment.color?.color ?? "Desconocido")")
                    .font(.caption)
                    .foregroundColor(.black.opacity(0.7))
            }
            .padding(.horizontal, 6)

            // Botón para eliminar la prenda
            Button(action: {
                Task {
                    if let index = viewModel.datosModelo.firstIndex(where: { $0.id == garment.id }) {
                        // Muestra loading
                        viewModel.isLoading = true
                        let success = await viewModel.deletePost(at: index)
                            await viewModel.getPosts()
                        viewModel.isLoading = false
                    }
                }
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .padding(5)
                    .background(Circle().fill(.white))
                    .shadow(radius: 5)
            }
            .padding(.top, 5)
        }
        .padding()
        .frame(width: 180, height: 280) // Ajusté la altura para acomodar el botón
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

