//
//  NetworkingProviderPost.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

class NetworkingProviderPOST: ObservableObject {
    func enviarPost(body: [String: Any]) async -> String? {
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings/") else {
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
    
    func enviarPost2(body: [String: Any]) async -> String? {
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings/") else {
            print("URL inválida")
            return nil
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Imprimir respuesta raw como string para depurar
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("📥 Respuesta raw del backend: \(rawResponse)")
            } else {
                print("⚠️ No se pudo convertir data a string para impresión")
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("🔵 Código HTTP recibido: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 201 || httpResponse.statusCode == 200 {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                        print("📦 JSON parseado: \(jsonObject)")
                        
                        if let jsonDict = jsonObject as? [String: Any] {
                            if let clothingId = jsonDict["id"] as? String {
                                print("✅ ID extraído: \(clothingId)")
                                return clothingId
                            } else {
                                print("❌ No se encontró la clave '_id' en el JSON")
                                print("📄 Claves disponibles: \(jsonDict.keys)")
                                return nil
                            }
                        } else {
                            print("❌ El JSON no es un diccionario [String: Any]")
                            return nil
                        }
                    } catch {
                        print("❌ Error al parsear JSON: \(error.localizedDescription)")
                        return nil
                    }
                } else {
                    let errorMsg = String(data: data, encoding: .utf8) ?? "Error desconocido"
                    print("❌ Error en la respuesta HTTP. Código: \(httpResponse.statusCode), mensaje: \(errorMsg)")
                    return nil
                }
            }
        } catch {
            print("❌ Error al enviar POST: \(error.localizedDescription)")
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
