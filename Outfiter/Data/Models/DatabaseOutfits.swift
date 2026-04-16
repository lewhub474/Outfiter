//
//  DatabaseOutfits.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

struct DatabaseOutfits: Codable, Identifiable {
    let name: String
    let clothings: [Clothing]
    let id: String
    
    //MARK: check what happens in this part of the code: Double Clothing Action 1
    
    struct Clothing: Codable, Identifiable {
        let name: String
        let color: Color
        let category: Category
        let id: String
        let image_url: String
    }
    
    struct Color: Codable {
        let color: String
        let id: String
    }
    
    struct Category: Codable {
        let category: String
        let id: String
    }
}
