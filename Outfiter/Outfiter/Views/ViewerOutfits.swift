//
//  ViewerOutfits.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation
import SwiftUI

import SwiftUI

struct ViewerOutfits: View {
    @StateObject var outfitViewModel = OutfitViewModel() // Usamos @StateObject para inicializar el ViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(outfitViewModel.outfits) { outfit in
                    NavigationLink(destination: OutfitDetailView(outfit: outfit)) {
                        Text(outfit.name)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let outfitToDelete = outfitViewModel.outfits[index]
                        outfitViewModel.deleteOutfit(at: outfitToDelete.id) // Usamos el ID correctamente
                    }
                }
            }
            .navigationBarTitle("Lista de Outfits")
            .onAppear {
                outfitViewModel.getOutfits() // Llamada al método de obtener outfits (ya no es necesario usar "FromAPI" directamente)
            }
        }
    }
}


//struct ViewerOutfits: View {
//    @StateObject var outfitViewModel = OutfitViewModel()
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(outfitViewModel.outfits) { outfit in
//                    NavigationLink(destination: OutfitDetailView(outfit: outfit)) {
//                        Text(outfit.name )
//                    }
//                }
//                .onDelete { indexSet in
//                    for index in indexSet {
//                        let outfitToDelete = outfitViewModel.outfits[index]
//                        outfitViewModel.deleteOutfit(at: outfitToDelete.id )
//                    }
//                }
//            }
//            .navigationBarTitle("Lista de Outfits")
//            .onAppear {
//                outfitViewModel.getOutfitsFromAPI()
//            }
//        }
//    }
//}
