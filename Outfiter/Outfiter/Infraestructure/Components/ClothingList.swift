//
//  Untitled.swift
//  Outfiter
//
//  Created by Macky on 3/06/25.
//

import SwiftUI

struct ClothingListView: View {
    let garments: [Garments]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(garments) { garment in
                    NavigationLink(destination: OutfitsForClothingView(clothing: garment)) {
                        ClothingCard(garment: garment)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
}
