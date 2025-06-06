//
//  GetOutfitsUseCaseProtocol.swift
//  Outfiter
//
//  Created by Macky on 24/02/25.
//

import Foundation

protocol GetOutfitsUseCaseProtocol {
    func execute() async throws -> [DatabaseOutfits]
}

