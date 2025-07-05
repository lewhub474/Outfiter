//
//  StorieItems.swift
//  Outfiter
//
//  Created by Macky on 2/07/25.
//

import SwiftUI

struct StoryItem: Identifiable {
    let id = UUID()
    let image: Image
    let label: String
    let borderColor: Color
    let action: () -> Void // Acción personalizada
}

struct StoryTabBar: View {
    let stories: [StoryItem]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(stories) { story in
                    Button(action: story.action) {
                        VStack {
                            ZStack {
                                Circle()
                                    .stroke(story.borderColor, lineWidth: 3)
                                    .frame(width: 74, height: 74)
                                
                                story.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 56, height: 56)
                                    .clipShape(Circle())
                            }
                            
                            Text(story.label)
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
        .background(Color.black)
    }
}

#Preview {
    StoryTabBar(stories: [
        StoryItem(
            image: Image("tendativa_banner"),
            label: "Tu historia",
            borderColor: .green,
            action: { print("Tu historia abierta") }
        ),
        StoryItem(
            image: Image(systemName: "person.fill"),
            label: "Juan",
            borderColor: .purple,
            action: { print("Juan seleccionado") }
        ),
        StoryItem(
            image: Image(systemName: "person.2.fill"),
            label: "Ana",
            borderColor: .gray,
            action: { print("Ana abierta") }
        ),
        StoryItem(
            image: Image(systemName: "star.fill"),
            label: "Visto",
            borderColor: .gray,
            action: { print("Vistos abiertos") }
        )
    ])
}


