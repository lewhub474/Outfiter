//
//  a.swift
//  Outfiter
//
//  Created by Macky on 24/02/25.
//
import Foundation

class GetOutfitsUseCase: GetOutfitsUseCaseProtocol {
    func execute() async throws -> [DatabaseOutfits] {
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/outfits") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let decodedOutfits = try decoder.decode([DatabaseOutfits].self, from: data)
        return decodedOutfits
    }
}
