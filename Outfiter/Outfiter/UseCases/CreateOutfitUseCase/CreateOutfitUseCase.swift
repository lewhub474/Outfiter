//
//  CreateOutfitUseCase.swift
//  Outfiter
//
//  Created by Macky on 22/02/25.
//

import Foundation

class CreateOutfitUseCase: CreateOutfitUseCaseProtocol {
    private let outfitRepository: OutfitRepositoryProtocol

    init(outfitRepository: OutfitRepositoryProtocol) {
        self.outfitRepository = outfitRepository
    }

    func execute(outfit garment: Garments, completion: @escaping (Result<Garments, Error>) -> Void) {
        outfitRepository.save(garment, completion: completion)
    }
}
