//
//  DeleteOutfitUseCase.swift
//  Outfiter
//
//  Created by Macky on 24/02/25.
//

import Foundation

protocol DeleteOutfitUseCaseProtocol {
    func execute(outfitID: String) async throws
}

