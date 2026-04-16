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
    @State private var selectedCategoryFilter: String = "Todas"
    @State private var categories: [Category] = []

    
    @State private var headerState: HeaderState = .expanded
    @State private var offset: CGFloat = .zero

    private let expandedHeaderHeight: CGFloat = 170
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
                            GIFView(gifName: "TDTV_loading") // Cambia por un gif de error si lo tienes
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
        
        
    }

    // MARK: - Header Content
    @ViewBuilder
    func headerContent() -> some View {
        VStack(spacing: 0) {
            TopBarView2(
                showSideMenu: $showSideMenu,
                userName: "Lewis Ferreira",
                profileImage: Image("tendativa_banner")
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.uniqueCategories, id: \.self) { category in
                        Button(action: {
                            selectedCategoryFilter = category
                        }) {
                            VStack {
                                ZStack {
                                    Circle()
                                        .stroke(selectedCategoryFilter == category ? Color.orange : Color.gray, lineWidth: 3)
                                        .frame(width: 74, height: 74)

                                    categoryImageView(for: category)

                                }

                                Text(category)
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .bold()
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            
            SearchBarView(text: $textSearch)
                .padding(.bottom, 10)
        }
        .background(Color.black)
    }

    // MARK: - Scroll Content
    @ViewBuilder
    func scrollableContent() -> some View {
        let spacing: CGFloat = 12
        let columns = [
            GridItem(.flexible(), spacing: spacing),
            GridItem(.flexible(), spacing: spacing)
        ]

        let filteredGarments = viewModel.datosModelo.filter { garment in
            let matchesCategory = selectedCategoryFilter == "Todas" ||
                garment.category?.category == selectedCategoryFilter

            let matchesSearch = textSearch.isEmpty ||
                (garment.name?.localizedCaseInsensitiveContains(textSearch) ?? false)

            return matchesCategory && matchesSearch
        }

        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(filteredGarments) { garment in
                    NavigationLink(destination: OutfitsForClothingView(clothing: garment)) {
                        ClothingCard(garment: garment, viewModel: viewModel)
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

    // MARK: - Helper
    @ViewBuilder
    func categoryImageView(for category: String) -> some View {
        if let imageURL = lastGarmentImageURL(for: category), let url = URL(string: imageURL) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 56, height: 56)
            .clipShape(Circle())
            .foregroundColor(.orange)
           
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(Circle())
                .foregroundColor(.gray)
        }
    }



    func lastGarmentImageURL(for category: String) -> String? {
        return viewModel.datosModelo
            .filter { $0.category?.category == category }
            .last?
            .imgURL
    }
}

#Preview {
    let mockViewModel = ClosetViewModelMock2(isLoading: false)
    ClosetView(viewModel: mockViewModel)
}

