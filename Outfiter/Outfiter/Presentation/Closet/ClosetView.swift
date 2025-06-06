//  Funcional
//  ClosetView.swift
//  Outfiter
//
//  Created by Andres Diaz  on 22/08/23.
//
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
    @StateObject var viewModel = ClosetViewModel()  // ViewModel
    @State private var selectedClothing: Garments? = nil
    @State private var showImageUploader = false
    @State private var uploadedImageURL: String? = nil
    @State private var showAddClothingWithImage = false

    var body: some View {
        NavigationView {
            ZStack {
                ClothingListView(garments: viewModel.datosModelo)
                    .blur(radius: viewModel.isLoading ? 3 : 0)
                    .disabled(viewModel.isLoading)

                if viewModel.isLoading {
                    SwiftUI.Color.black.opacity(0.2).ignoresSafeArea()
                    ProgressView("Cargando...")
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()

                        // Botón: Subir imagen (ImageUploader)
                        Button(action: {
                            showImageUploader.toggle()
                        }) {
                            Image(systemName: "square.and.arrow.down")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.trailing, 10)

                        // Botón: Añadir prenda sin imagen
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
                        .padding(.trailing, 10)

                        // Botón: Añadir prenda con imagen
                        Button(action: {
                            showAddClothingWithImage = true
                        }) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(.green)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitle("Closet")
            .navigationBarItems(
                leading: Button(action: {
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
            .task {
                await viewModel.getPosts()
            }
        }
        .sheet(isPresented: $showPostDataInput) {
            AddClothingView(
                name: $name,
                selectedCategory: $selectedCategory,
                selectedColor: $selectedColor
            )
            .onDisappear {
                Task {
                    await viewModel.getPosts()
                }
            }
        }
        .sheet(isPresented: $creatorOutfits) {
            CreateOutfitView(
                selectedClothingIDs: $selectedClothingIDs,
                outfitName: $outfitName,
                viewModel: viewModel,
                outfits: viewModel.datosModelo
            )
        }
        .sheet(isPresented: $showOutfits) {
            ViewerOutfits()
        }
        .sheet(isPresented: $showAddClothingWithImage) {
            AddClothingWithImageView(
                name: $name,
                selectedCategory: $selectedCategory,
                selectedColor: $selectedColor
            )
            .onDisappear {
                Task {
                    await viewModel.getPosts()
                }
            }
        }
        .environmentObject(viewModel)
    }
}
