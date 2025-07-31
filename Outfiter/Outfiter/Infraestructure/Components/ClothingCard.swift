//
//  ClothingCard.swift
//  Outfiter
//
//  Created by Macky on 3/06/25.
//

import SwiftUI

struct ClothingCard: View {
    let garment: Garments
    var viewModel: ClosetViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: garment.imgURL ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 240) // Relación 3:4
                        .clipped() // Recorta todo lo que se salga
                default:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 180, height: 240)
                }
            }
            
            // Capa inferior con nombre y botón
            HStack {
                Text(garment.name ?? "Sin nombre")
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                Button(action: {
                    print("🗑️ Borrando")
                    Task {
                        if let index = viewModel.datosModelo.firstIndex(where: { $0.id == garment.id }) {
                            viewModel.isLoading = true
                            
                            let eliminado = await viewModel.deletePost(at: index)
                            
                            if eliminado {
                                // Esperar 1 segundo para dar tiempo al backend
                                try? await Task.sleep(nanoseconds: 1_000_000_000)
                                print("🕒 Salió del delay, recargando lista desde el backend...")
                                
                                await viewModel.getPosts()
                            }
                            
                            viewModel.isLoading = false
                        }
                    }
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Circle().fill(Color.black.opacity(0.5)))
                }
            }
            .padding(8)
            .frame(width: 180)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 60), alignment: .bottom
            )
        }
        .frame(width: 180, height: 240)
        .cornerRadius(8)
        .clipped()
    }
}

#Preview {
    let sampleGarment = Garments(
        id: "",
        name: "Camiseta",
        category: Category(id: "", category: "Accesorios", image_url: ""),
        color: ColorClothes(id: "", color: "Amarillo"),
        imgURL: ""
    )
    
    let viewModel = ClosetViewModel()
    
    ZStack {
        Color.gray.opacity(0.2).ignoresSafeArea()
        
        ClothingCard(garment: sampleGarment, viewModel: viewModel)
            .environmentObject(viewModel)
    }
}


