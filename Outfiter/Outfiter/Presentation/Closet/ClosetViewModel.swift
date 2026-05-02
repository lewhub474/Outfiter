//
//  PostViewModel.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

class ClosetViewModel: ObservableObject {
    @Published var datosModelo = [Garments]()
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    
    private var provider = NetworkingProviderCloset()
    
    @MainActor
    func getPosts() async {
        print(">>> trajo las prendas")
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            datosModelo = try await provider.buscarData()
        } catch {
            errorMessage = "Sin conexión a internet o error inesperado."
            print("❌ Error al obtener prendas: \(error.localizedDescription)")
        }
    }

    func printseñal() {
        print("Aparecio el GIF")
    }
    
//    func deletePost(at index: Int) async -> Bool {
//        let outfitToDelete = datosModelo[index]
//        
//        let response = await provider.deletePost(postID: outfitToDelete.id ?? "")
//        if response == "Post eliminado" {
//            datosModelo.remove(at: index)
//            return true
//        } else {
//            return false
//        }
//    }
    
//    func deletePost(at index: Int) async -> Bool {
//        let outfitToDelete = datosModelo[index]
//        print("Intentando eliminar post con ID: \(outfitToDelete.id ?? "nil")")
//        
//        let response = await provider.deletePost(postID: outfitToDelete.id ?? "")
//        print("Respuesta del backend: \(response)")
//        
//        if response == "Post eliminado" {
//            datosModelo.remove(at: index)
//            print("Post eliminado localmente")
//            return true
//        } else {
//            print("Fallo al eliminar")
//            return false
//        }
//    }
    
    @MainActor
    func deletePost(at index: Int) async -> Bool {
        let outfitToDelete = datosModelo[index]
        print("Intentando eliminar post con ID: \(outfitToDelete.id ?? "nil")")

                let response = await provider.deletePost(postID: outfitToDelete.id ?? "")
        print("Respuesta del backend: \(String(describing: response))")

        if response == "Post eliminado" {
            await MainActor.run {
                withAnimation {
                    datosModelo.remove(at: index)
                }
            }
            print("Post eliminado localmente")
            return true
        }

        print("Fallo al eliminar")
        return false
    }


}

extension ClosetViewModel {
    var uniqueCategories: [String] {
        let categorias = datosModelo.compactMap { $0.category?.category }
        return ["Todas"] + Set(categorias).sorted()
    }
}

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField(
                "",
                text: $text,
                prompt: Text("My Closet")
                    .foregroundColor(.white.opacity(0.6))
                    .font(.headline)
            )
//            TextField("My Closet", text: $text)
//                .textFieldStyle(PlainTextFieldStyle())
//                .foregroundColor(.white)
//                .autocapitalization(.none)
//                .disableAutocorrection(true)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}


