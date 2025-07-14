//  Funcional
//  ClosetView.swift
//  Outfiter
//
//  Created by Andres Diaz  on 22/08/23.
//
//

import SwiftUI

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
    @State private var selectedClothing: Garments? = nil
    @State private var showImageUploader = false
    @State private var uploadedImageURL: String? = nil
    @State private var showAddClothingWithImage = false
    @State private var showSideMenu = false
    @State private var textSearch = ""

    @State private var headerState: HeaderState = .expanded
    @State private var offset: CGFloat = .zero

    private let expandedHeaderHeight: CGFloat = 150
    private let collapsedHeaderHeight: CGFloat = -140

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                CollapsableHeader(
                    expandedHeaderHeight: expandedHeaderHeight,
                    collapsedHeaderHeight: collapsedHeaderHeight,
                    offset: $offset,
                    headerState: $headerState,
                    headerView: headerContent,
                    scrollView: scrollableContent
                )

                if showSideMenu {
                    SideMenuView()
                        .transition(.move(edge: .leading))
                        .zIndex(1)
                }

                if viewModel.isLoading {
                    ZStack {
                        Color.black.opacity(0.4).ignoresSafeArea()
                        GIFView(gifName: "TDTV_loading")
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }

                if let error = viewModel.errorMessage {
                    ZStack {
                        Color.black.opacity(0.6).ignoresSafeArea()
                        VStack(spacing: 16) {
                            GIFView(gifName: "TDTV_loading") // Considera usar otro GIF para errores
                                .frame(width: 150, height: 150)
                            Text(error)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
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
//        .sheet(isPresented: $showAddClothingWithImage) {
//            AddClothingUploadImage(
//                name: $name,
//                selectedCategory: $selectedCategory,
//                selectedColor: $selectedColor
//            )
//            .onDisappear {
//                Task {
//                    await viewModel.getPosts()
//                }
//            }
//        }
//        .environmentObject(viewModel)
//        .ignoresSafeArea(.keyboard)
    }

    // MARK: - Header View
    @ViewBuilder
    func headerContent() -> some View {
        VStack(spacing: 0) {
            TopBarView2(
                showSideMenu: $showSideMenu,
                userName: "Lewis Ferreira",
                profileImage: Image("tendativa_banner")
            )

            StoryTabBar(stories: [
                StoryItem(image: Image("tendativa_banner"), label: "Favoritos", borderColor: .green, action: { print("Favoritos") }),
                StoryItem(image: Image("jacket.image"), label: "Camisetas", borderColor: .purple, action: { print("Camisetas") }),
                StoryItem(image: Image("pants.image"), label: "Pantalones", borderColor: .orange, action: { print("Pantalones") }),
                StoryItem(image: Image("headphones.image"), label: "Accesorios", borderColor: .gray, action: { print("Accesorios") })
            ])
        }
        .background(Color.black)
    }

    // MARK: - Scroll Content View
    @ViewBuilder
    func scrollableContent() -> some View {
        let spacing: CGFloat = 12
        let columns = [
            GridItem(.flexible(), spacing: spacing),
            GridItem(.flexible(), spacing: spacing)
        ]

        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(viewModel.datosModelo) { garment in
                    NavigationLink(destination: OutfitsForClothingView(clothing: garment)) {
                        ClothingCard(garment: garment)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.top, expandedHeaderHeight)
            .trackOffset(completion: { point in
                self.offset = point.y
            }, coordinatorSpace: "scrollView")
            .padding(.horizontal, spacing)
            .padding(.top, spacing)
            .padding(.bottom, 50)
        }
        .background(Color.black)
        .coordinateSpace(name: "scrollView")
        .blur(radius: viewModel.isLoading ? 3 : 0)
        .disabled(viewModel.isLoading)
    }
}


#Preview {
    let mockViewModel = ClosetViewModelMock2(isLoading: false)
    ClosetView(viewModel: mockViewModel)
}

