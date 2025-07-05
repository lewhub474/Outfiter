//
//  TopBarView.swift
//  Outfiter
//
//  Created by Macky on 26/06/25.
//

import SwiftUI

struct TopBarView: View {
    @Binding var showSideMenu: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                showSideMenu.toggle()
            }) {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .padding(.horizontal)
                    .foregroundColor(.black)
            }
            
            Text("Outfiter")
                .font(.title2)
                .bold()
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    print("Botón de crear pulsado")
                }) {
                    Image(systemName: "plus.app")
                        .foregroundColor(.black)
                }
                
                Button(action: {
                    print("Botón de mensajes pulsado")
                }) {
                    Image(systemName: "paperplane")
                        .foregroundColor(.black)
                }
            }
            .font(.title2)
            .padding(.horizontal)
        }
        .padding(.vertical, 10)
        .background(.orange)
        //        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
