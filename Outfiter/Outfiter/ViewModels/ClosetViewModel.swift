//
//  PostViewModel.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

final class ClosetViewModel: ObservableObject {
    @Published var datosModelo = [Garments]()
    private var provider = NetworkingProviderCloset()

    @MainActor func getPosts() async {
        self.datosModelo = await provider.buscarData() ?? []
    }

    func deletePost(at index: Int) {
        let outfitToDelete = datosModelo[index]
        
        Task {
            if let response = await provider.deletePost(postID: outfitToDelete.id ?? "") {
                if response == "Post eliminado" {
                    // Elimina el post eliminado de los datos locales
                    datosModelo.remove(at: index)
                }
            }
        }
    }
}
