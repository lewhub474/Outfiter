//
//  Prendas.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

struct Garments: Codable, Identifiable {
    let id: String?
    let name: String?
    let category: Category?
    let color: Color?
    let imgURL: String?
    var clothings: [Clothing]? // Agrega esta propiedad

    enum CodingKeys: String, CodingKey {
        case id, name, imgURL
        case category = "category"
        case color = "color"
    }
}
