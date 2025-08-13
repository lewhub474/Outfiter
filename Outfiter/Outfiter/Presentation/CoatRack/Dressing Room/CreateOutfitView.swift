//
//  CreateOutfitView.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//
//
//import SwiftUI
//
//struct CreateOutfitView: View {
//    @Binding var selectedTab: Int
//    @StateObject var closetViewModel = ClosetViewModel()
//    @StateObject private var viewModel = CreateOutfitViewModel()
//    @Environment(\.presentationMode) var presentationMode
//    @State private var showCompositionView = false
//
//
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                VStack {
//                    Text("Dressing Room")
//                        .font(.title)
//                        .bold()
//                        .padding(.top, 20)
//
//                    Text("Selecciona las prendas para tu outfit:")
//                        .font(.title3)
//                        .foregroundColor(.gray)
//
//                    TextField("Nombre del outfit", text: $viewModel.outfitName)
//                        .padding(10)
//                        .background(.white)
//                        .cornerRadius(8)
//                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1))
//                        .padding()
//
//                    TextField("Buscar prenda...", text: $viewModel.searchText)
//                        .padding(10)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(8)
//                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))
//                        .padding(.horizontal)
//
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 12) {
//                            ForEach(viewModel.uniqueCategories, id: \.self) { category in
//                                Button(action: {
//                                    viewModel.selectedCategory = category
//                                }) {
//                                    Text(category)
//                                        .font(.subheadline)
//                                        .padding(.vertical, 8)
//                                        .padding(.horizontal, 16)
//                                        .background(viewModel.selectedCategory == category ? Color.black : Color.gray.opacity(0.3))
//                                        .foregroundColor(viewModel.selectedCategory == category ? .white : .black)
//                                        .cornerRadius(16)
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//
//
//                    ScrollView {
//                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 12)], spacing: 12) {
//                            ForEach(viewModel.filteredClothing) { clothing in
//
//                                //                            ForEach(closetViewModel.datosModelo) { clothing in
//                                let isSelected = viewModel.selectedClothingIDs.contains(clothing.id ?? "")
//                                SelectableClothingCard(garment: clothing, isSelected: isSelected) {
//                                    if isSelected {
//                                        viewModel.selectedClothingIDs.removeAll { $0 == clothing.id }
//                                    } else {
//                                        viewModel.selectedClothingIDs.append(clothing.id ?? "")
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//
//                    Button("Crear Outfit") {
//                        showCompositionView = true
//                    }
//                    .frame(width: 200, height: 40)
//                    .background(.black)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//                    .padding()
//                    .fullScreenCover(isPresented: $showCompositionView) {
//                        OutfitCompositionView(
//                            images: viewModel.selectedClothingImages,
//                            onSave: {
//                                viewModel.enviarOutfit()
//                                showCompositionView = false
//                            },
//                            onCancel: {
//                                showCompositionView = false
//                            }
//                        )
//                    }
//
//
////                    Button("Crear Outfit") {
////                        viewModel.enviarOutfit()
////
////                    }
//
//                    .frame(width: 200, height: 40)
//                    .background(.black)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//                    .padding()
//
//                }
//                .padding(.bottom, 40)
//            }
//        }
//        .alert(isPresented: $viewModel.showSuccessPopup) {
//            Alert(
//                title: Text("Outfit creado"),
//                message: Text("Tu outfit ha sido creado exitosamente."),
//                dismissButton: .default(Text("OK")) {
//                    selectedTab = 3
//                    presentationMode.wrappedValue.dismiss()
//                }
//            )
//        }
//    }
//}

import SwiftUI

struct CreateOutfitView: View {
    @Binding var selectedTab: Int
    @StateObject var closetViewModel = ClosetViewModel()
    @StateObject private var viewModel = CreateOutfitViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showCompositionView = false
    
    @Binding var isTabBarVisible: Bool
    @State private var lastScrollOffset: CGFloat = 0
    @State private var scrollOffset: CGFloat = 0
    @State private var datoGuardado: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 6) {
                        GeometryReader { geo in
                            Color.clear
                                .preference(
                                    key: ScrollOffsetKey.self,
                                    value: geo.frame(in: .named("scrollArea")).minY
                                ) .onChange(of: geo.frame(in: .named("scrollArea")).minY) { newValue in
                                    datoGuardado = newValue
                                    
                                    if datoGuardado >= -49 && datoGuardado <= 0 {
                                        withAnimation(.easeInOut) { isTabBarVisible = true }
                                        print("📍 Entre 0 y -49 → mostrar TabBar: \(datoGuardado)")
                                    } else if datoGuardado <= -90 {
                                        withAnimation(.easeInOut) { isTabBarVisible = false }
                                        print("📍 -50 o menor → ocultar TabBar: \(datoGuardado)")
                                    }
                                }
                        }
                        .frame(height: 0)
                        
                        // Título principal centrado
                        Text("Dressing Room")
                            .font(.title2) // un poco más pequeño
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .padding(.top, 5)
                            .frame(maxWidth: .infinity) // permite centrar dentro del VStack

                        // Descripción centrada, más cercana al título
                        // Título principal centrado

                        // Descripción centrada, más cercana al título
                        Text("Selecciona las prendas para tu outfit:")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
//                            .padding(.top, 2) // espacio vertical reducido
                            .padding(.bottom, 8)
                            .frame(maxWidth: .infinity)

                        
                        TextField("Nombre del outfit", text: $viewModel.outfitName)
                            .padding(10)
                            .background(.white)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1))
                            .padding(.horizontal)
                        
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
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 12)], spacing: 12) {
                            ForEach(viewModel.filteredClothing) { clothing in
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
                        
                        Spacer(minLength: isTabBarVisible ? 60 : 20)
                    }
                }
                
                Button("Crear Outfit") {
                    showCompositionView = true
                }
                .frame(width: 200, height: 40)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom, isTabBarVisible ? 60 : 30)
                .zIndex(1)
                .fullScreenCover(isPresented: $showCompositionView) {
                    OutfitCompositionView(
                        images: viewModel.selectedClothingImages,
                        onSave: {
                            viewModel.enviarOutfit()
//                            showCompositionView = false
                        },
                        onCancel: {
                            showCompositionView = false
                        }, selectedTab: $selectedTab
                    )
                }
                
            }
        }
    }
}

// PreferenceKey para leer scroll
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
//
//#Preview {
//    struct PreviewWrapper: View {
//        @State var selectedTab: Int = 1
//        @State var isTabBarVisible: Bool = true
//
//        var body: some View {
//            CreateOutfitView(
//                selectedTab: $selectedTab,
//                isTabBarVisible: $isTabBarVisible
//            )
//        }
//    }
//    return PreviewWrapper()
//}

// Preview con Mock
struct CreateOutfitView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWithMock()
    }
    
    struct PreviewWithMock: View {
        @State var selectedTab: Int = 1
        @State var isTabBarVisible: Bool = true

        var body: some View {
            CreateOutfitView(
                selectedTab: $selectedTab,
                isTabBarVisible: $isTabBarVisible
            )
//            .environmentObject(ClosetViewModelMock2()) // Pasamos el mock si es necesario
        }
    }
}

// Preview sin Mock
struct CreateOutfitViewWithoutMock_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWithoutMock()
    }
    
    struct PreviewWithoutMock: View {
        @State var selectedTab: Int = 1
        @State var isTabBarVisible: Bool = true

        var body: some View {
            CreateOutfitView(
                selectedTab: $selectedTab,
                isTabBarVisible: $isTabBarVisible
            )
        }
    }
}
