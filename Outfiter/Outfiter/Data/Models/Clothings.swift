//
//  Clothings.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

struct Clothing: Codable, Identifiable { // Define la estructura Clothing para representar las prendas
    let id: String?
    let name: String?
    let category: Category?
    let color: ColorClothes?
    let imageUrl: String?
}
