//
//  CreateOutfitUseCaseProtocol.swift
//  Outfiter
//
//  Created by Macky on 22/02/25.
//

import Foundation

protocol CreateOutfitUseCaseProtocol {
    func execute(outfit: Garments, completion: @escaping (Result<Garments, Error>) -> Void)
}
