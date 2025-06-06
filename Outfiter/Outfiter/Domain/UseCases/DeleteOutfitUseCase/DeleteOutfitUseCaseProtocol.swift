//
//  DeleteOutfitUseCaseProtocol.swift
//  Outfiter
//
//  Created by Macky on 24/02/25.
//

import Foundation

class DeleteOutfitUseCase: DeleteOutfitUseCaseProtocol {
    func execute(outfitID: String) async throws {
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/outfits/\(outfitID)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 204 {
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Error eliminando outfit"])
        }
    }
}
