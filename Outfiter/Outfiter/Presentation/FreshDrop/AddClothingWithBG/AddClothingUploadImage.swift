//
//  AddClothingViewNew.swift
//  Outfiter
//
//  Created by Macky on 5/06/25.
//

import SwiftUI

struct AddClothingUploadImage: View {
    @Binding var name: String
    @State private var selectedCategory = "64ca77d45cf35ef21b7ece5a"
    @State private var selectedColor = "64ca772f5cf35ef21b7ece41"
    @Binding var selectedTab: Int
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
    @State private var selectedTab = 2
    
    var body: some View {
        AddClothingUploadImage(
            name: $name,
            selectedTab: $selectedTab
        )
    }
}





