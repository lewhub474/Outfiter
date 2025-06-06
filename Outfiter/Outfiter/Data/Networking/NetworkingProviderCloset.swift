//
//  NetworkingProvider.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

class NetworkingProviderCloset: ObservableObject {
    
    func buscarData() async -> [Garments]? {
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings") else {
            print("Url invalida")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // 🔍 Imprime el JSON crudo recibido del backend
            if let rawJSON = String(data: data, encoding: .utf8) {
                print("📥 JSON crudo recibido:\n\(rawJSON)")
            }

            // 🔄 Decodifica el JSON
            let decodedResponse = try JSONDecoder().decode([Garments].self, from: data)
            return decodedResponse
        }
        catch {
            print("❌ Error al decodificar el JSON: \(error)")
        }
      
        return nil
    }

//    func buscarData() async -> [Garments]? {
//        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings") else {
//            print("Url invalida")
//            return nil
//        }
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            if let decodedResponse = try? JSONDecoder().decode([Garments].self, from: data) {
//                return decodedResponse
//            }
//        }
//        catch {
//            print("Ops!")
//        }
//      
//        return nil
//    }

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
