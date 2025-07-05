//
//  ClosetViewModelMock.swift
//  Outfiter
//
//  Created by Macky on 5/07/25.
//

class ClosetViewModelMock: ClosetViewModel {
    init(isLoading: Bool = false) {
        
        super.init()
        self.isLoading = isLoading
        
        let category1 = Category(id: "1", category: "/", image_url: "https://via.placeholder.com/150")
        let category2 = Category(id: "2", category: "/", image_url: "https://via.placeholder.com/150")
        
        let color1 = ColorClothes(id: Optional("col1"), color: Optional("Blanco"))
        let color2 = ColorClothes(id: Optional("col2"), color: Optional("Azul"))
        
        let category3 = Category(id: "3", category: "/", image_url: "https://via.placeholder.com/150")
        let category4 = Category(id: "4", category: "/", image_url: "https://via.placeholder.com/150")
        
        let color3 = ColorClothes(id: Optional("col1"), color: Optional("Blanco"))
        let color4 = ColorClothes(id: Optional("col2"), color: Optional("Azul"))
        
        let category5 = Category(id: "5", category: "/", image_url: "https://via.placeholder.com/150")
        let category6 = Category(id: "6", category: "/", image_url: "https://via.placeholder.com/150")
        
        let color5 = ColorClothes(id: Optional("col1"), color: Optional("Blanco"))
        let color6 = ColorClothes(id: Optional("col2"), color: Optional("Azul"))
        
        let garment1 = Garments(
            id: Optional("1"),
            name: Optional("Camisa Blanca"),
            category: Optional(category1),
            color: Optional(color1),
            imgURL: Optional("https://via.placeholder.com/150"),
            clothings: Optional([])
        )
        
        let garment2 = Garments(
            id: Optional("2"),
            name: Optional("Jeans Azul"),
            category: Optional(category2),
            color: Optional(color2),
            imgURL: Optional("https://via.placeholder.com/150"),
            clothings: Optional([])
        )
        
        let garment3 = Garments(
            id: Optional("3"),
            name: Optional("Camisa Blanca"),
            category: Optional(category3),
            color: Optional(color3),
            imgURL: Optional("https://via.placeholder.com/150"),
            clothings: Optional([])
        )
        
        let garment4 = Garments(
            id: Optional("4"),
            name: Optional("Jeans Azul"),
            category: Optional(category4),
            color: Optional(color4),
            imgURL: Optional("https://via.placeholder.com/150"),
            clothings: Optional([])
        )
        
        let garment5 = Garments(
            id: Optional("5"),
            name: Optional("Camisa Blanca"),
            category: Optional(category5),
            color: Optional(color5),
            imgURL: Optional("https://via.placeholder.com/150"),
            clothings: Optional([])
        )
        
        let garment6 = Garments(
            id: Optional("6"),
            name: Optional("Jeans Azul"),
            category: Optional(category6),
            color: Optional(color6),
            imgURL: Optional("https://via.placeholder.com/150"),
            clothings: Optional([])
        )
        
        self.datosModelo = [garment1, garment2, garment3, garment4,garment5, garment6]
    }
    
    override func getPosts() async {
        // No hacer nada para evitar llamadas reales en el preview
    }
}


