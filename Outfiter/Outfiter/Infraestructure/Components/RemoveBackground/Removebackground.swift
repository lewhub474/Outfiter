//
//  Removebackground.swift
//  Outfiter
//
//  Created by Macky on 1/08/25.
//

import Foundation
import UIKit

import Foundation
import UIKit

class RemoveBGService {
    private let apiKey = "ZbCwmGAGWZwH64otGSS1Yewo"
    
    func removeBackground(from image: UIImage, completion: @escaping (Result<Data, Error>) -> Void) {
        print("🔁 Preparando imagen para enviar a Remove.bg...")

        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("❌ Error: no se pudo convertir UIImage a JPEG.")
            completion(.failure(NSError(domain: "InvalidImage", code: 0)))
            return
        }
        
        let url = URL(string: "https://api.remove.bg/v1.0/removebg")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        // Imagen
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image_file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Tamaño automático
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"size\"\r\n\r\n".data(using: .utf8)!)
        body.append("auto\r\n".data(using: .utf8)!)
        
        // Cierre
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        print("📤 Enviando solicitud a Remove.bg...")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Error de red: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("📬 Respuesta HTTP status code: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode != 200 {
                    if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("❌ Error de API: \(errorMessage)")
                    } else {
                        print("❌ Error desconocido desde API.")
                    }
                    completion(.failure(NSError(domain: "RemoveBG", code: httpResponse.statusCode)))
                    return
                }
            }

            if let data = data {
                print("✅ Imagen recibida sin fondo (tamaño: \(data.count) bytes)")
                completion(.success(data))
            }
        }.resume()
    }
}

import SwiftUI
import PhotosUI

struct RemoveBGView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var resultImage: UIImage?
    @State private var isLoading = false
    private let service = RemoveBGService()
    
    var body: some View {
        VStack(spacing: 20) {
            if let resultImage = resultImage {
                Image(uiImage: resultImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Text("Selecciona una imagen")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Text("Elegir Imagen")
                    .foregroundColor(.blue)
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImage = uiImage
                        print("🖼️ Imagen seleccionada, iniciando procesamiento...")
                        isLoading = true
                        removeBackground(from: uiImage)
                    } else {
                        print("⚠️ Error al cargar imagen seleccionada.")
                    }
                }
            }
            
            if isLoading {
                ProgressView("Eliminando fondo...")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
    
    func removeBackground(from image: UIImage) {
        service.removeBackground(from: image) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let data):
                    if let uiImage = UIImage(data: data) {
                        resultImage = uiImage
                        print("✅ Imagen procesada y mostrada.")
                    } else {
                        print("⚠️ No se pudo convertir los datos recibidos en UIImage.")
                    }
                case .failure(let error):
                    print("❌ Falló la eliminación de fondo: \(error.localizedDescription)")
                }
            }
        }
    }
}
