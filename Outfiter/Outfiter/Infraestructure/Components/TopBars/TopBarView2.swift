//
//  TopBarView2.swift
//  Outfiter
//
//  Created by Macky on 24/06/25.
//

import SwiftUI

struct TopBarView2: View {
    @Binding var showSideMenu: Bool
    var userName: String
    var profileImage: Image

    var body: some View {
        ZStack {
            // Vista lateral con elementos a la izquierda y derecha
            HStack(spacing: 16) {
                // Imagen a la izquierda
                HStack(spacing: 12) {
                    profileImage
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                }
                .padding(.horizontal, 8)
                .background(Color.black)
                
                Spacer()
                
                Button(action: {
                    showSideMenu.toggle()
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(8)
                    //                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            
//            Text("My Closet")
//                .font(.subheadline)
//                .foregroundColor(.white)
//                .bold()
        }
        .background(Color.black)
    }
}

#Preview {
    TopBarView2(
        showSideMenu: .constant(false),
        userName: "Test",
        profileImage: Image("tendativa_banner")
    )
}
