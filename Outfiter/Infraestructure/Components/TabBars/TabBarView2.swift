//
//  TabBarView2.swift
//  Outfiter
//
//  Created by Macky on 26/06/25.
//


//import SwiftUI
//
//struct TabBarView2: View {
//    @Binding var selectedTab: Int
//    @State private var isTabBarVisible = true
//    @State private var lastScrollOffset: CGFloat = 0
//
//    
//    var body: some View {
//        HStack {
//            TabBarButton2(icon: "hanger", index: 0, selectedTab: $selectedTab)
//            TabBarButton2(icon: "tshirt", index: 1, selectedTab: $selectedTab)
//            TabBarButton2(icon: "plus.app", index: 2, selectedTab: $selectedTab)
//            TabBarButton2(icon: "rectangle.3.group.fill", index: 3, selectedTab: $selectedTab)
//            TabBarButton2(icon: "person.crop.circle", index: 4, selectedTab: $selectedTab)
//        }
//        .padding(.vertical, 10)
//        .background(.black)
////        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: -2)
//    }
//}
//
//
//struct TabBarButton2: View {
//    let icon: String
//    let index: Int
//    @Binding var selectedTab: Int
//    
//    var body: some View {
//        Button(action: {
//            selectedTab = index
//        }) {
//            Image(systemName: icon)
//                .font(.title3)
//                .foregroundColor(selectedTab == index ? .orange : .white)
//                .frame(maxWidth: .infinity)
//        }
//    }
//}


import SwiftUI

struct TabBarView2: View {
    @Binding var selectedTab: Int
    @Binding var isTabBarVisible: Bool
    
    init(selectedTab: Binding<Int>, isTabBarVisible: Binding<Bool>? = nil) {
           self._selectedTab = selectedTab
           self._isTabBarVisible = isTabBarVisible ?? .constant(true)
       }
    
    var body: some View {
        if isTabBarVisible {
            HStack {
                TabBarButton2(icon: "hanger", index: 0, selectedTab: $selectedTab)
                TabBarButton2(icon: "tshirt", index: 1, selectedTab: $selectedTab)
                TabBarButton2(icon: "plus.app", index: 2, selectedTab: $selectedTab)
                TabBarButton2(icon: "rectangle.3.group.fill", index: 3, selectedTab: $selectedTab)
                TabBarButton2(icon: "person.crop.circle", index: 4, selectedTab: $selectedTab)
            }
            .padding(.vertical, 10)
            .background(.black)
            .transition(.move(edge: .bottom))
            .animation(.easeInOut, value: isTabBarVisible)
        }
    }
}

struct TabBarButton2: View {
    let icon: String
    let index: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(selectedTab == index ? .orange : .white)
                .frame(maxWidth: .infinity)
        }
    }
}
