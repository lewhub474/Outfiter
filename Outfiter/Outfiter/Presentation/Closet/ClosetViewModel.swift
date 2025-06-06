//
//  PostViewModel.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

final class ClosetViewModel: ObservableObject {
    @Published var datosModelo = [Garments]()
    @Published var isLoading = false

    private var provider = NetworkingProviderCloset()

    @MainActor
    func getPosts() async {
        isLoading = true
        datosModelo = await provider.buscarData() ?? []
        isLoading = false
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
