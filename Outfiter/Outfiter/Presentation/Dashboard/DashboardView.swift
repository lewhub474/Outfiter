//
//  DashboardView.swift
//  Outfiter
//
//  Created by Macky on 6/06/25.
//

import SwiftUI

struct DashboardView: View {
    @State private var selectedTab = 0
    @State private var showSideMenu = false
    @State private var name = ""
    @State private var selectedCategory = "64ca77d45cf35ef21b7ece5a"
    @State private var selectedColor = "64ca772f5cf35ef21b7ece41"
    @StateObject var viewModel = ClosetViewModel()
    @State private var selectedClothingIDs: [String] = []
    @State private var outfitName = ""

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()

            getSelectedView()
                .padding(.bottom, 20) // para no tapar el contenido con el tabbar

            TabBarView2(selectedTab: $selectedTab)
                .padding(.bottom, 5)
        }
        .task {
            await viewModel.getPosts()
        }
        .animation(.easeInOut, value: showSideMenu)
    }

    @ViewBuilder
    func getSelectedView() -> some View {
        switch selectedTab {
        case 0: ClosetView()
        case 1:CreateOutfitView(
            selectedTab: $selectedTab,
            closetViewModel: viewModel // este es el nombre correcto
        )

        case 2:
            AddClothingUploadImage(
                name: $name,
                selectedCategory: $selectedCategory,
                selectedColor: $selectedColor,
                selectedTab: $selectedTab
            )
        case 3: ViewerOutfits()
        case 4: ClosetCompositionView()
        default: ClosetView()
        }
    }

}


#Preview {
    DashboardView()
}







