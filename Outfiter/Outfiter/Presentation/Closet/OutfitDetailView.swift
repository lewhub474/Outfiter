//
//  OutfitDetailView.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation
import SwiftUI

struct OutfitDetailView: View {
    let outfit: DatabaseOutfits

    var body: some View {
        VStack {
            Text(outfit.name)
                .font(.title)

//            Text("Prendas en este outfit:")
//                .font(.headline)

            List(outfit.clothings) { clothing in
                HStack {
                    Text(clothing.name)
                    Spacer()
                    Text("Color: \(clothing.color.color)")
                    Text("Categoría: \(clothing.category.category)")
                }
            }
        }
        .padding()
//        .navigationBarTitle(outfit.name)
    }
}
