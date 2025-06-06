//
//  OutfitViewModel.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

class OutfitViewModel: ObservableObject {
    @Published var outfits = [DatabaseOutfits]()
    
    private let getOutfitsUseCase: GetOutfitsUseCaseProtocol
    private let deleteOutfitUseCase: DeleteOutfitUseCaseProtocol
    
    init(getOutfitsUseCase: GetOutfitsUseCaseProtocol = GetOutfitsUseCase(),
         deleteOutfitUseCase: DeleteOutfitUseCaseProtocol = DeleteOutfitUseCase()) {
        self.getOutfitsUseCase = getOutfitsUseCase
        self.deleteOutfitUseCase = deleteOutfitUseCase
    }

    func getOutfits() {
        Task {
            do {
                let fetchedOutfits = try await getOutfitsUseCase.execute()
                DispatchQueue.main.async { [weak self] in
                    self?.outfits = fetchedOutfits
                }
            } catch {
                print("Error al obtener los outfits: \(error)")
            }
        }
    }
    
    func deleteOutfit(at outfitID: String) {
        Task {
            do {
                try await deleteOutfitUseCase.execute(outfitID: outfitID)
                DispatchQueue.main.async { [weak self] in
                    self?.outfits.removeAll { $0.id == outfitID }
                }
            } catch {
                print("Error al eliminar el outfit: \(error)")
            }
        }
    }
}
