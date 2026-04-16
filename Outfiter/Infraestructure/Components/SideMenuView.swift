//
//  SideMenuView.swift
//  Outfiter
//
//  Created by Macky on 26/06/25.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Menú")
                .font(.title)
                .bold()
                .padding(.top, 60)
            
            Divider().padding(.vertical)
            
            Button("Perfil") {}
            Button("Configuración") {}
            Button("Cerrar sesión") {}
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: 250, alignment: .leading)
        .background(.white)
        .edgesIgnoringSafeArea(.all)
    }
}
