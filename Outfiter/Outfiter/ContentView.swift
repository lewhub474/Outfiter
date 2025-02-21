//  Funcional
//  ContentView.swift
//  Outfiter
//
//  Created by Andres Diaz  on 22/08/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject var viewModel = PostViewModel()
    @State private var showPostDataInput = false
    @State private var name = ""
    @State private var selectedCategory = "64ca77d45cf35ef21b7ece5a"
    @State private var selectedColor = "64ca772f5cf35ef21b7ece41"
    @State private var creatorOutfits = false
    @State private var showOutfits = false
    @State private var selectedClothingIDs: [String] = []
    @State private var outfitName = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(viewModel.datosModelo) { post in
                            HStack {
                                Text(post.name ?? "Nil")
//                                Text(post.color?.color ?? "Nil")

                                Spacer()
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                viewModel.deletePost(at: index)
                            }
                        }
                    }
                    .task {
                        await viewModel.getPosts()
                    }
                    .navigationBarTitle("Closet")
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showPostDataInput.toggle()
                        }) {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
                .padding(.trailing, 16)
            }
            .navigationBarItems(leading:
                                    Button(action: {
                                        creatorOutfits.toggle()
                                    }) {
                                        HStack{
                                            Image(systemName: "person.and.background.dotted")
                                                .font(.subheadline)
                                                .foregroundColor(.blue)
                                            Text("Dressing Room").foregroundColor(.blue)
                                        }
                                    },
                                trailing: Button(action: {
                                    showOutfits.toggle()
                                }) {
                                    HStack{
                                        Image(systemName: "star.circle")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                        Text("Outfits").foregroundColor(.blue)
                                    }
                                }
            )
        }
        .sheet(isPresented: $showPostDataInput) {
            PostDataInputView(name: $name, selectedCategory: $selectedCategory, selectedColor: $selectedColor)
                .onDisappear {
                    Task {
                        await viewModel.getPosts()
                    }
                }
        }
        .sheet(isPresented: $creatorOutfits) {
            CreateOutfitView(selectedClothingIDs: $selectedClothingIDs, outfitName: $outfitName, viewModel: viewModel, outfits: viewModel.datosModelo)
        }
        .sheet(isPresented: $showOutfits) {
            ViewerOutfits()
        }
    }
}

