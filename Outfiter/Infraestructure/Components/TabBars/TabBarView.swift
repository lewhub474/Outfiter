//
//  TabBarView.swift
//  Outfiter
//
//  Created by Macky on 26/06/25.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabBarButton(icon: "hanger", index: 0, selectedTab: $selectedTab)
            TabBarButton(icon: "tshirt", index: 1, selectedTab: $selectedTab)
            TabBarButton(icon: "plus.app", index: 2, selectedTab: $selectedTab)
            TabBarButton(icon: "rectangle.3.group.fill", index: 3, selectedTab: $selectedTab)
            TabBarButton(icon: "person.crop.circle", index: 4, selectedTab: $selectedTab)
        }
        .padding(.vertical, 5)
        .background(.white)
//        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: -2)
    }
}

struct TabBarButton: View {
    let icon: String
    let index: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(selectedTab == index ? .orange : .black)
                .frame(maxWidth: .infinity)
        }
    }
}
