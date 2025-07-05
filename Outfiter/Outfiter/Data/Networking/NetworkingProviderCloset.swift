//
//  NetworkingProvider.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

class NetworkingProviderCloset: ObservableObject {
    
    func buscarData() async throws -> [Garments] {
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let rawJSON = String(data: data, encoding: .utf8) {
            print("📥 JSON crudo recibido:\n\(rawJSON)")
        }
        
        let decodedResponse = try JSONDecoder().decode([Garments].self, from: data)
        return decodedResponse
    }
    
    
    func deletePost(postID: String) async -> String? {
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings/\(postID)") else {
            print("URL inválida")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 204 {
                    return "Post eliminado"
                }
            }
        } catch {
            print("Error al eliminar el post: \(error)")
        }
        
        return nil
    }
}
