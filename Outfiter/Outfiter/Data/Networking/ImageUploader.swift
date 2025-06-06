//
//  ImageUploader.swift
//  Outfiter
//
//  Created by Macky on 20/04/25.
//

//import Foundation
//
//struct ImageUploader {
//    static func upload(imageData: Data, for clothingId: String) async -> Clothing? {
//        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings/image/\(clothingId)") else {
//            return nil
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        let boundary = UUID().uuidString
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        var body = Data()
//        body.append("--\(boundary)\r\n")
//        body.append("Content-Disposition: form-data; name=\"my_file\"; filename=\"image.jpg\"\r\n")
//        body.append("Content-Type: image/jpeg\r\n\r\n")
//        body.append(imageData)
//        body.append("\r\n")
//        body.append("--\(boundary)--\r\n")
//
//        request.httpBody = body
//
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//
//            if let httpResponse = response as? HTTPURLResponse {
//                print("📡 Código de estado: \(httpResponse.statusCode)")
//            }
//
//            return try JSONDecoder().decode(Clothing.self, from: data)
//        } catch {
//            print("❌ Error subiendo imagen: \(error)")
//            return nil
//        }
//    }
//}
//
//
//extension Data {
//    mutating func append(_ string: String) {
//        if let data = string.data(using: .utf8) {
//            append(data)
//        }
//    }
//}
//
//import SwiftUI
//import PhotosUI
//
//struct ImageUploadView: View {
//    @State private var selectedItem: PhotosPickerItem?
//    @State private var selectedImage: UIImage?
//    @State private var uploadResult: String?
//
//    let categoryId = "64ca77d45cf35ef21b7ece5a"
//    let colorId = "64ca772f5cf35ef21b7ece41"
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                PhotosPicker("Seleccionar imagen", selection: $selectedItem, matching: .images)
//                    .onChange(of: selectedItem) { newItem in
//                        Task {
//                            if let data = try? await newItem?.loadTransferable(type: Data.self),
//                               let uiImage = UIImage(data: data) {
//                                selectedImage = uiImage
//                            }
//                        }
//                    }
//
//                if let selectedImage = selectedImage {
//                    Image(uiImage: selectedImage)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 250)
//                        .cornerRadius(12)
//
//                    Button("Crear prenda y subir imagen") {
//                        Task {
//                            await crearPrendaYSubirImagen()
//                        }
//                    }
//                    .buttonStyle(.borderedProminent)
//                }
//
//                if let result = uploadResult {
//                    Text(result)
//                        .foregroundColor(.green)
//                        .padding()
//                }
//            }
//            .padding()
//            .navigationTitle("Subir Imagen")
//        }
//    }
//
//    private func crearPrendaYSubirImagen() async {
//        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.8) else {
//            uploadResult = "❌ No se pudo obtener imagen"
//            return
//        }
//
//        // 1. Crear prenda
//        guard let clothing = await ClothingService.createClothing(name: "Mi Prenda", categoryId: categoryId, colorId: colorId),
//              let clothingId = clothing.id else {
//            uploadResult = "❌ Error al crear la prenda"
//            return
//        }
//
//        // 2. Subir imagen
//        if let updatedClothing = await ImageUploader.upload(imageData: imageData, for: clothingId) {
//            uploadResult = "✅ Imagen subida a: \(updatedClothing.imageUrl ?? "sin URL")"
//        } else {
//            uploadResult = "❌ Error al subir imagen"
//        }
//    }
//}
//
//
//struct UploadResponse: Decodable {
//    let image_url: String
//}
//
//struct ClothingService {
//    static func createClothing(name: String, categoryId: String, colorId: String) async -> Clothing? {
//        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings") else {
//            return nil
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let body: [String: Any] = [
//            "name": name,
//            "category": categoryId,
//            "color": colorId
//        ]
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: body)
//
//            let (data, _) = try await URLSession.shared.data(for: request)
//            let clothing = try JSONDecoder().decode(Clothing.self, from: data)
//            return clothing
//        } catch {
//            print("❌ Error creando prenda: \(error)")
//            return nil
//        }
//    }
//}
