//
//  CollapsableHeader.swift
//  Outfiter
//
//  Created by Macky on 7/07/25.
//
import SwiftUI

struct CollapsableHeader<HeaderView: View, ScrollView: View>: View {
    let expandedHeaderHeight: CGFloat
    let collapsedHeaderHeight: CGFloat
    let headerView: (() -> HeaderView)
    let scrollView: (() -> ScrollView)
    @Binding var offset: CGFloat
    @Binding var headerState: HeaderState
    @StateObject var viewModel = ClosetViewModel()
    
    init(expandedHeaderHeight: CGFloat,
         collapsedHeaderHeight: CGFloat,
         offset: Binding<CGFloat>,
         headerState: Binding<HeaderState>,
         headerView: @escaping () -> HeaderView,
         scrollView: @escaping () -> ScrollView) {
        self.expandedHeaderHeight = expandedHeaderHeight
        self.collapsedHeaderHeight = collapsedHeaderHeight
        self._offset = offset
        self._headerState = headerState
        self.headerView = headerView
        self.scrollView = scrollView
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            scrollView()
            
            headerView() // Collapsible header
                .frame(height: expandedHeaderHeight)
                .offset(y: getOffset(offset: offset))
                .zIndex(1) // Ensure the header stays on top
        }
        
        
    }
    
    private func getOffset(offset: CGFloat) -> CGFloat {
        guard offset < .zero else { return .zero }
        if offset > -(expandedHeaderHeight - collapsedHeaderHeight) {
            updateHeaderState(currentState: headerState, futureState: .expanded)
            return offset
        } else {
            updateHeaderState(currentState: headerState, futureState: .collapsed)
            return -(expandedHeaderHeight - collapsedHeaderHeight)
        }
    }
    
    private func updateHeaderState(currentState: HeaderState,
                                   futureState: HeaderState) {
        if currentState != futureState {
            DispatchQueue.main.async {
                self.headerState = futureState
            }
        }
    }
}

//MARK: Preview

struct CollapsableHeaderPreview: View {
    @StateObject var viewModel = ClosetViewModel()
    @State var headerState: HeaderState = .expanded
    @State var offset: CGFloat = .zero
    
    private let expandedHeaderHeight: CGFloat = 60
    private let collapsedHeaderHeight: CGFloat = -140
    let garments: [Garments]  // propiedad normal
    
    init(garments: [Garments]) {
        self.garments = garments
    }
    
    var body: some View {
        CollapsableHeader(expandedHeaderHeight: expandedHeaderHeight,
                          collapsedHeaderHeight: collapsedHeaderHeight,
                          offset: $offset,
                          headerState: $headerState,
                          headerView: headerView,
                          scrollView: scrollableView)
    }
    
    @ViewBuilder
    func headerView() -> some View {
        TopBarView2(
            showSideMenu: .constant(false),
            userName: "Test",
            profileImage: Image("tendativa_banner")
        )
    }
    
    @ViewBuilder
    func scrollableView() -> some View {
        let spacing: CGFloat = 12
        let columns = [
            GridItem(.flexible(), spacing: spacing),
            GridItem(.flexible(), spacing: spacing)
        ]
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) { // Espaciado vertical
                ForEach(garments) { garment in
                    NavigationLink(destination: OutfitsForClothingView(clothing: garment)) {
                        ClothingCard(garment: garment, viewModel: viewModel)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.top, expandedHeaderHeight) // Set top padding as expanded header height
            .trackOffset(completion: { offset in
                self.offset = offset.y
            }, coordinatorSpace: "scrollView")
            .padding(.horizontal, spacing)
            .padding(.top, spacing)
        }
        .background(.black)
        .coordinateSpace(name: "scrollView")
    }
}

#Preview {
    
    CollapsableHeaderPreview( garments: [
        Garments(
            id: "1",
            name: "Chaqueta",
            category: Category(id: "1", category: "Ropa exterior", image_url: ""),
            color: ColorClothes(id: "1", color: "Negro"),
            imgURL: "https://via.placeholder.com/180x240"
        ),
        Garments(
            id: "2",
            name: "Camiseta",
            category: Category(id: "2", category: "Casual", image_url: ""),
            color: ColorClothes(id: "2", color: "Rojo"),
            imgURL: "https://via.placeholder.com/180x240"
        ),
        
        Garments(
            id: "3",
            name: "Chaqueta",
            category: Category(id: "3", category: "Ropa exterior", image_url: ""),
            color: ColorClothes(id: "3", color: "Negro"),
            imgURL: "https://via.placeholder.com/180x240"
        ),
        Garments(
            id: "4",
            name: "Camiseta",
            category: Category(id: "4", category: "Casual", image_url: ""),
            color: ColorClothes(id: "4", color: "Rojo"),
            imgURL: "https://via.placeholder.com/180x240"
        ),
        
        Garments(
            id: "5",
            name: "Chaqueta",
            category: Category(id: "5", category: "Ropa exterior", image_url: ""),
            color: ColorClothes(id: "5", color: "Negro"),
            imgURL: "https://via.placeholder.com/180x240"
        )
        ,
        
        Garments(
            id: "6",
            name: "Chaqueta",
            category: Category(id: "6", category: "Ropa exterior", image_url: ""),
            color: ColorClothes(id: "6", color: "Negro"),
            imgURL: "https://via.placeholder.com/180x240"
        )
        ,
        
        Garments(
            id: "7",
            name: "Chaqueta",
            category: Category(id: "7", category: "Ropa exterior", image_url: ""),
            color: ColorClothes(id: "7", color: "Negro"),
            imgURL: "https://via.placeholder.com/180x240"
        )
    ])
}


