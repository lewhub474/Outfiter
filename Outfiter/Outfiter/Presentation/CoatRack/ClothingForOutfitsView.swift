//
//  ClothingForOutfitsView.swift
//  Outfiter
//
//  Created by Macky on 24/02/25.
//

import Foundation
import SwiftUI

struct OutfitsForClothingView: View {
    let clothing: Garments  // La prenda seleccionada
    @StateObject var outfitViewModel = OutfitViewModel()

    var body: some View {
        NavigationView {
            List {
                // Filtrar los outfits para mostrar solo aquellos que contienen la prenda seleccionada
                ForEach(outfitViewModel.outfits.filter { outfit in
                    outfit.clothings.contains(where: { $0.id == clothing.id })
                }) { outfit in
                    NavigationLink(destination: OutfitDetailView(outfit: outfit)) {
                        Text(outfit.name)
                    }
                }
            }
            .navigationBarTitle("Outfits for \(clothing.name ?? "Unknown")")
            .onAppear {
                outfitViewModel.getOutfits() // Asegúrate de llamar al método correcto de obtener los outfits
            }
        }
    }
}

