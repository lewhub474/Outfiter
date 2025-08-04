//
//  CreateOutfitView.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import SwiftUI

struct CreateOutfitView: View {
    @Binding var selectedTab: Int
    @StateObject var closetViewModel = ClosetViewModel()
    @StateObject private var viewModel = CreateOutfitViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showCompositionView = false

    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Dressing Room")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)
                    
                    Text("Selecciona las prendas para tu outfit:")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    TextField("Nombre del outfit", text: $viewModel.outfitName)
                        .padding(10)
                        .background(.white)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1))
                        .padding()
                    
                    TextField("Buscar prenda...", text: $viewModel.searchText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.uniqueCategories, id: \.self) { category in
                                Button(action: {
                                    viewModel.selectedCategory = category
                                }) {
                                    Text(category)
                                        .font(.subheadline)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(viewModel.selectedCategory == category ? Color.black : Color.gray.opacity(0.3))
                                        .foregroundColor(viewModel.selectedCategory == category ? .white : .black)
                                        .cornerRadius(16)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 12)], spacing: 12) {
                            ForEach(viewModel.filteredClothing) { clothing in
                                
                                //                            ForEach(closetViewModel.datosModelo) { clothing in
                                let isSelected = viewModel.selectedClothingIDs.contains(clothing.id ?? "")
                                SelectableClothingCard(garment: clothing, isSelected: isSelected) {
                                    if isSelected {
                                        viewModel.selectedClothingIDs.removeAll { $0 == clothing.id }
                                    } else {
                                        viewModel.selectedClothingIDs.append(clothing.id ?? "")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Button("Crear Outfit") {
                        showCompositionView = true
                    }
                    .frame(width: 200, height: 40)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    .fullScreenCover(isPresented: $showCompositionView) {
                        OutfitCompositionView(
                            images: viewModel.selectedClothingImages,
                            onSave: {
                                viewModel.enviarOutfit()
                                showCompositionView = false
                            },
                            onCancel: {
                                showCompositionView = false
                            }
                        )
                    }

                    
//                    Button("Crear Outfit") {
//                        viewModel.enviarOutfit()
//                        
//                    }
                    
                    .frame(width: 200, height: 40)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    
                }
                .padding(.bottom, 40)
            }
        }
        .alert(isPresented: $viewModel.showSuccessPopup) {
            Alert(
                title: Text("Outfit creado"),
                message: Text("Tu outfit ha sido creado exitosamente."),
                dismissButton: .default(Text("OK")) {
                    selectedTab = 3
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var selectedClothingIDs: [String] = []
        @State var outfitName: String = ""
        @State var selectedTab: Int = 1
        
        var body: some View {
            CreateOutfitView(
                selectedTab: $selectedTab,
                closetViewModel: ClosetViewModelMock2()
            )
            
        }
    }
    return PreviewWrapper()
}


