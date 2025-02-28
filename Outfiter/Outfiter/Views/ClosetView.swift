//  Funcional
//  ClosetView.swift
//  Outfiter
//
//  Created by Andres Diaz  on 22/08/23.
//

import SwiftUI
import Foundation

struct ClosetView: View {
    @State private var showPostDataInput = false
    @State private var name = ""
    @State private var selectedCategory = "64ca77d45cf35ef21b7ece5a"
    @State private var selectedColor = "64ca772f5cf35ef21b7ece41"
    @State private var creatorOutfits = false
    @State private var showOutfits = false
    @State private var selectedClothingIDs: [String] = []
    @State private var outfitName = ""
    @StateObject var viewModel = ClosetViewModel()
    @State private var selectedClothing: Garments? = nil  // Prenda seleccionada
    
    var body: some View {
        NavigationView {
            ZStack {
                // Contenido principal con lista de prendas
                List {
                    ForEach(viewModel.datosModelo) { post in
                        // Mostrar cada prenda y navegar a los outfits donde aparece
                        NavigationLink(destination: OutfitsForClothingView(clothing: post)) {
                            Text(post.name ?? "Nil")
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            viewModel.deletePost(at: index)
                        }
                    }
                }
                .task {
                    await viewModel.getPosts()
                }
                .navigationBarTitle("Closet")
                .navigationBarItems(leading:
                                        Button(action: {
                                            creatorOutfits.toggle()
                                        }) {
                                            HStack {
                                                Image(systemName: "person.and.background.dotted")
                                                    .font(.subheadline)
                                                    .foregroundColor(.black)
                                                Text("Dressing Room").foregroundColor(.black)
                                            }
                                        },
                                    trailing: Button(action: {
                                        showOutfits.toggle()
                                    }) {
                                        HStack {
                                            Image(systemName: "star.circle")
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                            Text("Outfits").foregroundColor(.black)
                                        }
                                    }
                )

                // Botón flotante para agregar nuevas prendas
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showPostDataInput.toggle()
                        }) {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding()
                                .background(.black)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $showPostDataInput) {
            AddClothingView(name: $name, selectedCategory: $selectedCategory, selectedColor: $selectedColor)
                .onDisappear {
                    Task {
                        await viewModel.getPosts()
                    }
                }
        }
        .sheet(isPresented: $creatorOutfits) {
            CreateOutfitView(selectedClothingIDs: $selectedClothingIDs, outfitName: $outfitName, viewModel: viewModel, outfits: viewModel.datosModelo)
        }
        .sheet(isPresented: $showOutfits) {
            ViewerOutfits()
        }
    }
}
