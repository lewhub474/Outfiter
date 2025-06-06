//
//  AddClothingViewNew.swift
//  Outfiter
//
//  Created by Macky on 5/06/25.
//

import SwiftUI

struct AddClothingWithImageView: View {
    
    @Binding var name: String
    @Binding var selectedCategory: String
    @Binding var selectedColor: String
    @StateObject private var viewModel = AddClothingWithImageViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    
    @State private var showSourceTypeActionSheet = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary


    var body: some View {
        VStack {
            Text("Suma al Closet con Imagen")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Form {
                TextField("Nombre", text: $name)
                
                Picker("Categoría", selection: $selectedCategory) {
                    ForEach(viewModel.categories, id: \.id) { category in
                        Text(category.category ?? "Desconocido").tag(category.id ?? "")
                    }
                }
                
                Picker("Color", selection: $selectedColor) {
                    ForEach(viewModel.colors, id: \.id) { color in
                        Text(color.color ?? "Desconocido").tag(color.id ?? "")
                    }
                }
                
                Button("Seleccionar Imagen") {
                    showSourceTypeActionSheet = true
                }
                .actionSheet(isPresented: $showSourceTypeActionSheet) {
                    ActionSheet(title: Text("Selecciona el origen de la imagen"), buttons: [
                        .default(Text("Galería")) {
                            imageSourceType = .photoLibrary
                            showImagePicker = true
                        },
                        .default(Text("Cámara")) {
                            imageSourceType = .camera
                            showImagePicker = true
                        },
                        .cancel()
                    ])
                }

//                Button("Seleccionar Imagen") {
//                    showImagePicker = true
//                }
//                
//                if let image = selectedImage {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 150)
//                        .cornerRadius(10)
//                }
            }

            Button(action: {
                viewModel.addClothingWithImage(name: name,
                                               categoryId: selectedCategory,
                                               colorId: selectedColor,
                                               image: selectedImage) {
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Añadir Prenda")
                    .frame(width: 200, height: 40)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage, sourceType: imageSourceType)
        }

//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $selectedImage)
//        }
    }
}


import Foundation
import SwiftUI

class AddClothingWithImageViewModel: ObservableObject {
    
    @Published var categories: [Category] = [
        Category(id: "64ca77c85cf35ef21b7ece56", category: "Accesorios", image_url: ""),
        Category(id: "64ca77ce5cf35ef21b7ece58", category: "Camisas", image_url: ""),
        Category(id: "64ca77d45cf35ef21b7ece5a", category: "Pantalones", image_url: ""),
        Category(id: "64ca77d95cf35ef21b7ece5c", category: "Zapatos", image_url: "")
    ]
    
    @Published var colors: [Color] = [
        Color(id: "64ca77265cf35ef21b7ece3f", color: "Rojo"),
        Color(id: "64ca772f5cf35ef21b7ece41", color: "Amarillo"),
        Color(id: "64ca77335cf35ef21b7ece43", color: "Azul"),
        Color(id: "64ca773b5cf35ef21b7ece45", color: "Violeta"),
    ]
    
    private let postProvider = NetworkingProviderPOST()
    private let imageUploader = ImageUploadProvider()
    private let closetViewModel = ClosetViewModel()
    
    func addClothingWithImage(name: String, categoryId: String, colorId: String, image: UIImage?, completion: @escaping () -> Void) {
        Task {
            let body: [String: Any] = [
                "name": name,
                "category": categoryId,
                "color": colorId
            ]
            
            guard let clothingId = await postProvider.enviarPost2(body: body) else {
                print("❌ Error al crear prenda")
                return
            }
            
            if let image = image {
                await imageUploader.uploadImage(clothingId: clothingId, image: image)
            }
            
            await closetViewModel.getPosts()
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

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


import SwiftUI
import UIKit

//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController,
//                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//            }
//
//            picker.dismiss(animated: true)
//        }
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
