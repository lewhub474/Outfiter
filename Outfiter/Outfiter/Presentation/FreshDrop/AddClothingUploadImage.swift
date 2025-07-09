//
//  AddClothingViewNew.swift
//  Outfiter
//
//  Created by Macky on 5/06/25.
//

import SwiftUI

//struct AddClothingUploadImage: View {
//    
//    @Binding var name: String
//    @Binding var selectedCategory: String
//    @Binding var selectedColor: String
//    @StateObject private var viewModel = AddClothingWithImageViewModel()
//    @Environment(\.presentationMode) var presentationMode
//    
//    @State private var selectedImage: UIImage?
//    @State private var showImagePicker = false
//    
//    @State private var showSourceTypeActionSheet = false
//    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
//
//
//    var body: some View {
//        VStack {
//            Text("Suma al Closet con Imagen")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding(.top, 20)
//
//            Form {
//                TextField("Nombre", text: $name)
//                
//                Picker("Categoría", selection: $selectedCategory) {
//                    ForEach(viewModel.categories, id: \.id) { category in
//                        Text(category.category ?? "Desconocido").tag(category.id ?? "")
//                    }
//                }
//                
//                Picker("Color", selection: $selectedColor) {
//                    ForEach(viewModel.colors, id: \.id) { color in
//                        Text(color.color ?? "Desconocido").tag(color.id ?? "")
//                    }
//                }
//                
//                Button("Seleccionar Imagen") {
//                    showSourceTypeActionSheet = true
//                }
//                .actionSheet(isPresented: $showSourceTypeActionSheet) {
//                    ActionSheet(title: Text("Selecciona el origen de la imagen"), buttons: [
//                        .default(Text("Galería")) {
//                            imageSourceType = .photoLibrary
//                            showImagePicker = true
//                        },
//                        .default(Text("Cámara")) {
//                            imageSourceType = .camera
//                            showImagePicker = true
//                        },
//                        .cancel()
//                    ])
//                }
//
////                Button("Seleccionar Imagen") {
////                    showImagePicker = true
////                }
////                
////                if let image = selectedImage {
////                    Image(uiImage: image)
////                        .resizable()
////                        .scaledToFit()
////                        .frame(height: 150)
////                        .cornerRadius(10)
////                }
//            }
//
//            Button(action: {
//                viewModel.addClothingWithImage(name: name,
//                                               categoryId: selectedCategory,
//                                               colorId: selectedColor,
//                                               image: selectedImage) {
//                    presentationMode.wrappedValue.dismiss()
//                }
//            }) {
//                Text("Añadir Prenda")
//                    .frame(width: 200, height: 40)
//                    .background(.black)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//        }.sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $selectedImage, sourceType: imageSourceType)
//        }
//
////        .sheet(isPresented: $showImagePicker) {
////            ImagePicker(image: $selectedImage)
////        }
//    }
//}

import SwiftUI

import SwiftUI

struct AddClothingUploadImage: View {
      @Binding var name: String
      @Binding var selectedCategory: String
      @Binding var selectedColor: String
      @Binding var selectedTab: Int // 👈 aquí
    @StateObject private var viewModel = AddClothingWithImageViewModel()
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showSourceTypeActionSheet = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showSuccessAlert = false


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Suma al Closet con Imagen")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)

                // Imagen seleccionada
                // Imagen con TextField superpuesto
                
                //MARK: AQUI
                Text("Imagen de la prenda")
                    .foregroundColor(.white)
                    .font(.headline)
                HStack{
                    Spacer()
                    ZStack(alignment: .bottom) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 240)
                                .clipped()
                                .cornerRadius(10)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 180, height: 240)
                                .overlay(
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                        .foregroundColor(.gray)
                                )
                                .cornerRadius(10)
                        }
                        
                        // TextField superpuesto como en ClothingCard
                        ClothingNameEditor(name: $name)

                    }
                 Spacer()
                }
                .cornerRadius(10)


                // Botón seleccionar imagen
                Button("Seleccionar Imagen") {
                    showSourceTypeActionSheet = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(8)

                // Nombre
                Text("Nombre de la prenda")
                    .font(.headline)
                    .foregroundColor(.white)

                TextField("Nombre", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.white)
                    .accentColor(.orange)

                // Categoría
                Text("Categoría de la prenda")
                    .font(.headline)
                    .foregroundColor(.white)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.categories, id: \.id) { category in
                            VStack {
                                Image(systemName: "tshirt")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(
                                        selectedCategory == (category.id ?? "") ?
                                        Color.orange.opacity(0.8) :
                                        Color.gray.opacity(0.3)
                                    )
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        selectedCategory = category.id ?? ""
                                    }

                                Text(category.category ?? "Desconocido")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }

                // Color
                Text("Color de la prenda")
                    .font(.headline)
                    .foregroundColor(.white)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.colors, id: \.id) { color in
                            VStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.gray)
                                    .padding()
                                    .background(
                                        selectedColor == (color.id ?? "") ?
                                        Color.orange.opacity(0.8) :
                                        Color.gray.opacity(0.3)
                                    )
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        selectedColor = color.id ?? ""
                                    }

                                Text(color.color ?? "Desconocido")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }

                // Botón añadir Prenda
//                Button(action: {
//                    viewModel.addClothingWithImage(name: name,
//                                                   categoryId: selectedCategory,
//                                                   colorId: selectedColor,
//                                                   image: selectedImage) {
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                }) {
//                    Text("Añadir Prenda")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.orange)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
                
                Button(action: {
                    viewModel.addClothingWithImage(name: name,
                                                   categoryId: selectedCategory,
                                                   colorId: selectedColor,
                                                   image: selectedImage) {
                        showSuccessAlert = true
                       

                    }
                }) {
                    Text("Añadir Prenda")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }


                Spacer()
            }
            .padding()
        }
        .onTapGesture {
            hideKeyboard()
        }
        .background(Color.black)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage, sourceType: imageSourceType)
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
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Prenda añadida"),
                message: Text("Se agregó exitosamente al closet."),
                dismissButton: .default(Text("OK")) {
                    selectedTab = 0 // 👈 Navega después de cerrar el popup
                }
            )
        }


    }
}

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var name = "Camiseta Tommy Hilfiger"
    @State private var selectedCategory = "1"
    @State private var selectedColor = "1"
    @State private var selectedTab = 2

    var body: some View {
        AddClothingUploadImage(
            name: $name,
            selectedCategory: $selectedCategory,
            selectedColor: $selectedColor,
            selectedTab: $selectedTab
        )
    }
}


//#Preview {
//    @State var name = "Camiseta Tommy Hilferd"
//    @State var selectedCategory = "1"
//    @State var selectedColor = "1"
//
//    AddClothingUploadImage(name: $name,
//                                   selectedCategory: $selectedCategory,
//                           selectedColor: $selectedColor, selectedTab: <#Binding<Int>#>)
//}

import Foundation
import SwiftUI

class AddClothingWithImageViewModel: ObservableObject {
    
    @Published var categories: [Category] = [
        Category(id: "64ca77c85cf35ef21b7ece56", category: "Accesorios", image_url: ""),
        Category(id: "64ca77ce5cf35ef21b7ece58", category: "Camisas", image_url: ""),
        Category(id: "64ca77d45cf35ef21b7ece5a", category: "Pantalones", image_url: ""),
        Category(id: "64ca77d95cf35ef21b7ece5c", category: "Zapatos", image_url: "")
    ]
    
    @Published var colors: [ColorClothes] = [
        ColorClothes(id: "64ca77265cf35ef21b7ece3f", color: "Rojo"),
        ColorClothes(id: "64ca772f5cf35ef21b7ece41", color: "Amarillo"),
        ColorClothes(id: "64ca77335cf35ef21b7ece43", color: "Azul"),
        ColorClothes(id: "64ca773b5cf35ef21b7ece45", color: "Violeta"),
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
                // 🔧 Aplica crop centrado
//                parent.image = uiImage.cropToSquare()
                parent.image = uiImage.cropToSquare(from: .left)

            }

            picker.dismiss(animated: true)
        }

//        func imagePickerController(_ picker: UIImagePickerController,
//                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                let cropped = cropToSquare(image: uiImage)
//                parent.image = cropped
//            }
//            picker.dismiss(animated: true)
//        }

        // Recorta la imagen al centro en una relación 1:1
        func cropToSquare(image: UIImage) -> UIImage {
            let originalWidth  = image.size.width
            let originalHeight = image.size.height

            let squareLength = min(originalWidth, originalHeight)
            let x = (originalWidth - squareLength) / 2.0
            let y = (originalHeight - squareLength) / 2.0

            let cropRect = CGRect(x: x, y: y, width: squareLength, height: squareLength)

            if let cgImage = image.cgImage?.cropping(to: cropRect) {
                return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
            } else {
                return image // fallback
            }
        }

//        func imagePickerController(_ picker: UIImagePickerController,
//                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//            }
//
//            picker.dismiss(animated: true)
//        }
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


import UIKit

extension UIImage {
    func cropToSquare() -> UIImage? {
        let originalWidth  = self.size.width
        let originalHeight = self.size.height
        
        let sideLength = min(originalWidth, originalHeight)
        
        let originX = (originalWidth - sideLength) / 2.0
        let originY = (originalHeight - sideLength) / 2.0
        
        let cropRect = CGRect(x: originX, y: originY, width: sideLength, height: sideLength)
        guard let cgImage = self.cgImage?.cropping(to: cropRect) else { return nil }

        return UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
    }
}

enum CropAlignment {
    case center
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

extension UIImage {
    func cropToSquare(from alignment: CropAlignment = .center) -> UIImage? {
        let originalWidth  = self.size.width
        let originalHeight = self.size.height
        let sideLength = min(originalWidth, originalHeight)

        var originX: CGFloat = 0
        var originY: CGFloat = 0

        switch alignment {
        case .center:
            originX = (originalWidth - sideLength) / 2
            originY = (originalHeight - sideLength) / 2
        case .top:
            originX = (originalWidth - sideLength) / 2
            originY = 0
        case .bottom:
            originX = (originalWidth - sideLength) / 2
            originY = originalHeight - sideLength
        case .left:
            originX = 0
            originY = (originalHeight - sideLength) / 2
        case .right:
            originX = originalWidth - sideLength
            originY = (originalHeight - sideLength) / 2
        case .topLeft:
            originX = 0
            originY = 0
        case .topRight:
            originX = originalWidth - sideLength
            originY = 0
        case .bottomLeft:
            originX = 0
            originY = originalHeight - sideLength
        case .bottomRight:
            originX = originalWidth - sideLength
            originY = originalHeight - sideLength
        }

        let cropRect = CGRect(x: originX, y: originY, width: sideLength, height: sideLength)
        guard let cgImage = self.cgImage?.cropping(to: cropRect) else { return nil }

        return UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
    }
}


//struct ClothingNameEditor: View {
//    @Binding var name: String
//    let width: CGFloat
//    let height: CGFloat
//
//    private let maxLines = 3
//
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            if name.isEmpty {
//                Text("Nombra tu prenda aquí")
//                    .foregroundColor(Color.white.opacity(0.6))
//                    .padding(.horizontal, 8)
//                    .padding(.top, 12)
//            }
//
//            TextEditor(text: $name)
//                .frame(width: width, height: height)
//                .padding(4)
//                .foregroundColor(.white)
//                .font(.headline)
//                .background(
//                    LinearGradient(
//                        gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
//                        startPoint: .bottom,
//                        endPoint: .top
//                    )
//                )
//                .cornerRadius(10)
//                .scrollContentBackground(.hidden)
//                .onChange(of: name) { newValue in
//                    let lines = newValue.components(separatedBy: "\n")
//                    if lines.count > maxLines {
//                        name = lines.prefix(maxLines).joined(separator: "\n")
//                    }
//                }
//        }
//        .frame(width: width, height: height)
//    }
//}

struct ClothingNameEditor: View {
    @Binding var name: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if name.isEmpty {
                Text("Nombra tu prenda aquí")
                    .foregroundColor(Color.white.opacity(0.6))
                    .padding(.horizontal, 8)
                    .padding(.bottom, 10)
            }

            TextEditor(text: $name)
                .frame(width: 180, height: 60)
                .padding(4)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .foregroundColor(.white)
                .font(.headline)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.6)
                .cornerRadius(8)
                .scrollContentBackground(.hidden)
        }
        .frame(width: 180, height: 60)
    }
}
