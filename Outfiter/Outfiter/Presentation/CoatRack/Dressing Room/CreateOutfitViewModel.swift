//
//  CreateOutfitViewModel.swift
//  Outfiter
//
//  Created by Macky on 11/07/25.
//

import Foundation
import SwiftUI

@MainActor
final class CreateOutfitViewModel: ObservableObject {
    @Published var selectedClothingIDs: [String] = []
    @Published var outfitName: String = ""
    @Published var showSuccessPopup: Bool = false
    @Published var outfitResponse: String?

    private let postProvider = NetworkingProviderOutfit()

    func enviarOutfit(viewModel: ClosetViewModel) {
        guard !selectedClothingIDs.isEmpty, !outfitName.isEmpty else {
            outfitResponse = "Debes seleccionar prendas y proporcionar un nombre."
            return
        }

        let invalidIDs = selectedClothingIDs.filter { id in
            !viewModel.datosModelo.contains { $0.id == id }
        }

        if !invalidIDs.isEmpty {
            outfitResponse = "IDs de prendas inválidos: \(invalidIDs.joined(separator: ", "))"
            return
        }

        let selectedClothingNames = viewModel.datosModelo
            .filter { selectedClothingIDs.contains($0.id ?? "") }
            .compactMap { $0.name }

        let selectedCategoryNames = viewModel.datosModelo
            .filter { selectedClothingIDs.contains($0.id ?? "") }
            .compactMap { $0.category?.category }

        let selectedColorNames = viewModel.datosModelo
            .filter { selectedClothingIDs.contains($0.id ?? "") }
            .compactMap { $0.color?.color }

        print("Nombre del Outfit: \(outfitName)")
        print("Nombres de las prendas seleccionadas: \(selectedClothingNames.joined(separator: ", "))")
        print("IDs seleccionados de prendas: \(selectedClothingIDs.joined(separator: ", "))")
        print("Categorías seleccionadas: \(selectedCategoryNames.joined(separator: ", "))")
        print("Colores seleccionados: \(selectedColorNames.joined(separator: ", "))")

        let body: [String: Any] = [
            "name": outfitName,
            "clothings": selectedClothingIDs
        ]

        Task {
            if let response = await postProvider.enviarPost(body: body) {
                outfitResponse = response
                selectedClothingIDs.removeAll()
                outfitName = ""
                showSuccessPopup = true
//                onSuccess() // Cambiar de pestaña y cerrar vista
            } else {
                outfitResponse = "Error al crear el outfit."
            }
        }
    }
}
