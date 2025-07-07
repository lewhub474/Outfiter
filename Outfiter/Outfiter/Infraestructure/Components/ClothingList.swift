//
//  Untitled.swift
//  Outfiter
//
//  Created by Macky on 3/06/25.
//

import SwiftUI

import SwiftUI

struct ClothingListView: View {
    let garments: [Garments]
    
    // Espaciado horizontal entre columnas
    private let spacing: CGFloat = 12
    
    // Dos columnas con espaciado uniforme
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) { // Espaciado vertical
                ForEach(garments) { garment in
                    NavigationLink(destination: OutfitsForClothingView(clothing: garment)) {
                        ClothingCard(garment: garment)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, spacing)
            .padding(.top, spacing)
        }
        .background(.black)
    }
}

#Preview {
    let sampleGarments = [
        Garments(
            id: "1",
            name: "Chaqueta",
            category: Category(id: "1", category: "Ropa exterior", image_url: ""),
            color: ColorClothes(id: "1", color: "Negro"),
            imgURL: "https://via.placeholder.com/180x240"
        ),
        Garments(
            id: "2",
            name: "Camiseta",
            category: Category(id: "2", category: "Casual", image_url: ""),
            color: ColorClothes(id: "2", color: "Rojo"),
            imgURL: "https://via.placeholder.com/180x240"
        ),
        
        Garments(
            id: "3",
            name: "Chaqueta",
            category: Category(id: "3", category: "Ropa exterior", image_url: ""),
            color: ColorClothes(id: "3", color: "Negro"),
            imgURL: "https://via.placeholder.com/180x240"
        ),
        Garments(
            id: "4",
            name: "Camiseta",
            category: Category(id: "4", category: "Casual", image_url: ""),
            color: ColorClothes(id: "4", color: "Rojo"),
            imgURL: "https://via.placeholder.com/180x240"
        )
    ]

    let viewModel = ClosetViewModel()

    return NavigationView {
        ClothingListView(garments: sampleGarments)
            .environmentObject(viewModel) // Necesario para ClothingCard2
    }
}


