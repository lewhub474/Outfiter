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
    @State private var showSideMenu = false
    @State private var textSearch = ""
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    
                    TopBarView2(showSideMenu: $showSideMenu, userName: "Lewis Ferreira", profileImage:   Image("tendativa_banner"))
                    
                    StoryTabBar(stories: [
                        StoryItem(
                            image: Image("tendativa_banner"),
                            label: "Favoritos",
                            borderColor: .green,
                            action: { print("Favoritos") }
                        ),
                        StoryItem(
                            image: Image("jacket.image"),
                            label: "Camisetas",
                            borderColor: .purple,
                            action: { print("Camisetas") }
                        ),
                        StoryItem(
                            image: Image("pants.image"),
                            label: "Pantalones",
                            borderColor: .orange,
                            action: { print("Pantalones") }
                        ),
                        StoryItem(
                            image: Image( "headphones.image"),
                            label: "Accesorios",
                            borderColor: .gray,
                            action: { print("Accesorios") }
                        )
                    ])
                    
                    //                        .padding(.vertical, 30)
                    //                    CustomTextField(placeholder: "Encuentra", text: $textSearch)
                    //                        .padding(.horizontal, 15)
                    //                        .padding(.vertical, 5)
                    
                    ZStack {
                        ClothingListView(garments: viewModel.datosModelo) .ignoresSafeArea()
                            .blur(radius: viewModel.isLoading ? 3 : 0)
                            .disabled(viewModel.isLoading)
                        //                        VStack {
                        if viewModel.isLoading {
                            
                            ZStack {
                                SwiftUI.Color.black.opacity(0.4).ignoresSafeArea()
                                
                                GIFView(gifName: "TDTV_loading")
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }.onAppear {
                                viewModel.printseñal()
                            }
                        }
                        
                        if let error = viewModel.errorMessage {
                            ZStack {
                                Color.black.opacity(0.6).ignoresSafeArea()
                                VStack(spacing: 16) {
                                    GIFView(gifName: "TDTV_loading") // Puedes usar uno distinto para errores
                                        .frame(width: 150, height: 150)
                                    Text(error)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        
                        if showSideMenu {
                            SideMenuView()
                                .transition(.move(edge: .leading))
                                .zIndex(1)
                        }
                    }
                    
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        
        
        .task {
            await viewModel.getPosts()
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
        
        .sheet(isPresented: $showOutfits) {
            ViewerOutfits()
        }
        .sheet(isPresented: $showAddClothingWithImage) {
            AddClothingUploadImage(
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

#Preview {
    let mockViewModel = ClosetViewModelMock(isLoading: false)
    ClosetView(viewModel: mockViewModel)
}

