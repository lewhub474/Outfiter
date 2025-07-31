//
//  CreateOutfitViewModel.swift
//  Outfiter
//
//  Created by Macky on 11/07/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class CreateOutfitViewModel: ObservableObject {
    @Published var selectedClothingIDs: [String] = []
    @Published var outfitName: String = ""
    @Published var showSuccessPopup: Bool = false
    @Published var outfitResponse: String?
    @Published var closetData: [Garments] = []
    @Published var searchText: String = ""
    @Published var selectedCategory: String = "Todas"
    
    private let postProvider = NetworkingProviderOutfit()
    private var cancellables = Set<AnyCancellable>()
    private let closetViewModel = ClosetViewModel()
    
    init() {
        observeClosetData()
        Task {
            await closetViewModel.getPosts()
        }
    }
    
    private func observeClosetData() {
        closetViewModel.$datosModelo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] garments in
                self?.closetData = garments
                print("Closet data actualizada con \(garments.count) prendas")
            }
            .store(in: &cancellables)
    }
    
    var filteredClothing: [Garments] {
        closetData.filter { clothing in
            let matchesSearch = searchText.isEmpty ||
            (clothing.name?.localizedCaseInsensitiveContains(searchText) ?? false)
            
            let matchesCategory = selectedCategory == "Todas" ||
            (clothing.category?.category == selectedCategory)
            
            return matchesSearch && matchesCategory
        }
    }
    
    var uniqueCategories: [String] {
        let categories = closetData.compactMap { $0.category?.category }.filter { !$0.isEmpty }
        let unique = Set(categories)
        return ["Todas"] + unique.sorted()
    }
    
    func enviarOutfit() {
        guard !selectedClothingIDs.isEmpty, !outfitName.isEmpty else {
            outfitResponse = "Debes seleccionar prendas y proporcionar un nombre."
            return
        }
        
        let invalidIDs = selectedClothingIDs.filter { id in
            !closetData.contains { $0.id == id }
        }
        
        if !invalidIDs.isEmpty {
            outfitResponse = "IDs de prendas inválidos: \(invalidIDs.joined(separator: ", "))"
            return
        }
        
        let selectedClothingNames = closetData
            .filter { selectedClothingIDs.contains($0.id ?? "") }
            .compactMap { $0.name }
        
        let selectedCategoryNames = closetData
            .filter { selectedClothingIDs.contains($0.id ?? "") }
            .compactMap { $0.category?.category }
        
        let selectedColorNames = closetData
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
            } else {
                outfitResponse = "Error al crear el outfit."
            }
        }
    }
}
