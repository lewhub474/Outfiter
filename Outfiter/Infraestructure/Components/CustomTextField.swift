//
//  CustomTextField.swift
//  Outfiter
//
//  Created by Macky on 9/06/25.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var onSearch: () -> Void = {}

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(10)

            Button(action: onSearch) {
                Image(systemName: "magnifyingglass.circle.fill")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
            }
            .padding(.trailing, 10)
        }
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

