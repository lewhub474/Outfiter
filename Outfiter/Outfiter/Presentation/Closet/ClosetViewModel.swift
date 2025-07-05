//
//  PostViewModel.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

class ClosetViewModel: ObservableObject {
    @Published var datosModelo = [Garments]()
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    
    private var provider = NetworkingProviderCloset()
    
    @MainActor
    func getPosts() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            datosModelo = try await provider.buscarData()
        } catch {
            errorMessage = "Sin conexión a internet o error inesperado."
            print("❌ Error al obtener prendas: \(error.localizedDescription)")
        }
    }

    func printseñal() {
        print("Aparecio el GIF")
    }
    
    func deletePost(at index: Int) async -> Bool {
        let outfitToDelete = datosModelo[index]
        
        let response = await provider.deletePost(postID: outfitToDelete.id ?? "")
        if response == "Post eliminado" {
            datosModelo.remove(at: index)
            return true
        } else {
            return false
        }
    }
}
