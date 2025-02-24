//
//  FloatingButton.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation
import SwiftUI

struct FloatingButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding()
                .background(.cyan)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding()
        .background(.green)
        .position(x: UIScreen.main.bounds.width - 40, y: UIScreen.main.bounds.height - 80)
    }
}
