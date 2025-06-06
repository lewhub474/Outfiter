//
//  OutfitRepositoryProtocol.swift
//  Outfiter
//
//  Created by Macky on 22/02/25.
//

import Foundation

// Protocolo para definir las operaciones relacionadas con la entidad "Outfit"
protocol OutfitRepositoryProtocol {
    func save(_ outfit: Garments, completion: @escaping (Result<Garments, Error>) -> Void)
    func fetchAll(completion: @escaping (Result<[Garments], Error>) -> Void)
    func delete(_ outfit: Garments, completion: @escaping (Result<Void, Error>) -> Void)
}
