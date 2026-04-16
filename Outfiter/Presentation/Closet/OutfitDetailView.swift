//
//  OutfitDetailView.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

//import Foundation
//import SwiftUI
//
//struct OutfitDetailView: View {
//    let outfit: DatabaseOutfits
//
//    var body: some View {
//        VStack {
//            Text(outfit.name)
//                .font(.title)
//
////            Text("Prendas en este outfit:")
////                .font(.headline)
//
//            List(outfit.clothings) { clothing in
//                HStack {
//                    Text(clothing.name)
//                    Spacer()
//                    Text("Color: \(clothing.color.color)")
//                    Text("Categoría: \(clothing.category.category)")
//                }
//            }
//        }
//        .padding()
////        .navigationBarTitle(outfit.name)
//    }
//}


import SwiftUI

struct OutfitDetailView: View {
    let outfit: DatabaseOutfits
    @State private var items: [DraggableImage] = []
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            // Collage dinámico
            ForEach($items) { $item in
                DraggableResizableImage(item: $item)
            }
        }
        .onAppear {
            // Convertimos clothings → DraggableImage inicial
            items = outfit.clothings.map { clothing in
                DraggableImage(
                    name: clothing.image_url,
                    position: CGPoint(
                        x: UIScreen.main.bounds.width / 2,
                        y: UIScreen.main.bounds.height / 2
                    ),
                    scale: 1.0
                )
            }
        }
        .overlay(
            VStack {
                Text(outfit.name)
                    .font(.headline)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .padding(.top, 40)
                Spacer()
            },
            alignment: .top
        )
    }
}


struct DraggableResizableImage: View {
    @Binding var item: DraggableImage
    
    var body: some View {
        AsyncImage(url: URL(string: item.name)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120 * item.scale, height: 160 * item.scale)
                    .position(item.position)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                item.position = value.location
                            }
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                item.scale = value
                            }
                    )
            case .failure(_):
                Color.gray
                    .frame(width: 120, height: 160)
                    .position(item.position)
            case .empty:
                ProgressView()
                    .frame(width: 120, height: 160)
                    .position(item.position)
            @unknown default:
                EmptyView()
            }
        }
    }
}
