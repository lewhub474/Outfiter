//
//  NetworkingProviderOutfits.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

class NetworkingProviderOutfit: ObservableObject {
    func enviarPost(body: [String: Any]) async -> String? {
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/outfits/") else {
            print("URL inválida")
            return nil
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let (data, _) = try await URLSession.shared.data(for: request)
            if let responseMessage = String(data: data, encoding: .utf8) {
                return responseMessage
            }
        } catch {
            print("Error al enviar POST: \(error)")
        }
        
        return nil
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
