//
//  AddClothingUploadImageViewModel.swift
//  Outfiter
//
//  Created by Macky on 1/08/25.
//

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
