//
//  ImageUploadProvider.swift
//  Outfiter
//
//  Created by Macky on 1/08/25.
//


import Foundation
import UIKit

class ImageUploadProvider {
    
    func saveImageToTempDirectory(image: UIImage) -> URL? {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            print("❌ No se pudo convertir la imagen a JPEG")
            return nil
        }
        
        let tempDir = FileManager.default.temporaryDirectory
        let fileName = UUID().uuidString + ".jpg"
        let fileURL = tempDir.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            print("✅ Imagen guardada temporalmente en: \(fileURL.path)")
            return fileURL
        } catch {
            print("❌ Error al guardar la imagen temporalmente: \(error)")
            return nil
        }
    }
    
    func uploadImage(clothingId: String, image: UIImage) async {
        // Guarda la imagen temporalmente para ver la ruta en consola
        if let localURL = saveImageToTempDirectory(image: image) {
            print("📍 Ruta local de la imagen a subir: \(localURL.path)")
        }
        
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings/image/\(clothingId)") else {
            print("❌ URL inválida")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("❌ No se pudo convertir la imagen a JPEG")
            return
        }
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"my_file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: body)
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("✅ Imagen subida correctamente")
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("📦 Respuesta del servidor: \(json)")
                    }
                } else {
                    print("❌ Error en la respuesta. Código: \(httpResponse.statusCode)")
                    if let errorMsg = String(data: data, encoding: .utf8) {
                        print("🪵 Mensaje del servidor: \(errorMsg)")
                    }
                }
            }
        } catch {
            print("❌ Error de red al subir imagen: \(error)")
        }
    }
}
