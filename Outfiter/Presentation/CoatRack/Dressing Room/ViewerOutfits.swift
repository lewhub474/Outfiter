//
//  ViewerOutfits.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//
//
//import SwiftUI MARK: ESTE SIRVE
//
//struct ViewerOutfits: View {
//    @StateObject var outfitViewModel = OutfitViewModel() // Usamos @StateObject para inicializar el ViewModel
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(outfitViewModel.outfits) { outfit in
//                    NavigationLink(destination: OutfitDetailView(outfit: outfit)) {
//                        Text(outfit.name)
//                    }
//                }
//                .onDelete { indexSet in
//                    for index in indexSet {
//                        let outfitToDelete = outfitViewModel.outfits[index]
//                        outfitViewModel.deleteOutfit(at: outfitToDelete.id) // Usamos el ID correctamente
//                    }
//                }
//            }
//            .navigationBarTitle("Lista de Outfits")
//            .onAppear {
//                outfitViewModel.getOutfits() // Llamada al método de obtener outfits (ya no es necesario usar "FromAPI" directamente)
//            }
//        }
//    }
//}


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

import SwiftUI

//struct ViewerOutfits: View {
//    @StateObject var outfitViewModel = OutfitViewModel()
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                LazyVStack(spacing: 16) {
//                    ForEach(outfitViewModel.outfits) { outfit in
//                        NavigationLink(destination: OutfitDetailView(outfit: outfit)) {
//                            OutfitCardPinterestView(outfit: outfit)
//                        }
//                        .buttonStyle(PlainButtonStyle()) // Quita el azul por defecto
//                    }
//                }
//                .padding()
//                .padding(.bottom, 40)
//                
//            }
//            .navigationBarTitle("Lista de Outfits")
//            .onAppear {
//                outfitViewModel.getOutfits()
//            }
//        }
//    }
//}

import SwiftUI

struct ViewerOutfits: View {
    @StateObject var outfitViewModel = OutfitViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(outfitViewModel.outfits) { outfit in
                        NavigationLink(destination: OutfitDetailView(outfit: outfit)) {
                            OutfitCardPinterestView(outfit: outfit)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
                .padding(.bottom, 40)
            }
            .navigationBarTitle("Lista de Outfits")
            .navigationBarTitleDisplayMode(.inline) // opcional
            .tint(.black) // 👈 botones y "Atrás" en negro
            .onAppear {
                outfitViewModel.getOutfits()
            }
        }
    }
}


import SwiftUI

struct OutfitCardPinterestView: View {
    let outfit: DatabaseOutfits  // DTO directamente
    
    // Tamaño base para los ítems
    private let itemWidth: CGFloat = 80
    private var itemHeight: CGFloat { itemWidth * 4 / 3 } // relación 3:4
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Nombre del outfit
            Text(outfit.name)
                .font(.headline)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
            
            // Grid con celdas uniformes
            let columns = [GridItem(.adaptive(minimum: itemWidth), spacing: 6)]
            
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(outfit.clothings) { clothing in
                    AsyncImage(url: URL(string: clothing.image_url)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: itemWidth, height: itemHeight) // 👈 tamaño fijo 3:4
                                .clipped()
                                .cornerRadius(6)
                        case .failure(_):
                            Color.gray
                                .frame(width: itemWidth, height: itemHeight)
                                .cornerRadius(6)
                        case .empty:
                            ProgressView()
                                .frame(width: itemWidth, height: itemHeight)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
            .padding(8)
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
    }
}
