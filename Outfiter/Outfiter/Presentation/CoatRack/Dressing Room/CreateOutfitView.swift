//
//  CreateOutfitView.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//


import SwiftUI

struct CreateOutfitView: View {
    @Binding var selectedTab: Int
    @ObservedObject var closetViewModel: ClosetViewModel
    @StateObject private var viewModel = CreateOutfitViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Dressing Room")
                        .font(.title)
                        .bold()
                        .padding(.top, 20)

                    Text("Selecciona las prendas para tu outfit:")
                        .font(.title3)
                        .foregroundColor(.gray)

                    TextField("Nombre del outfit", text: $viewModel.outfitName)
                        .padding(10)
                        .background(.white)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1))
                        .padding()

                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 12)], spacing: 12) {
                            ForEach(closetViewModel.datosModelo) { clothing in
                                let isSelected = viewModel.selectedClothingIDs.contains(clothing.id ?? "")
                                SelectableClothingCard(garment: clothing, isSelected: isSelected) {
                                    if isSelected {
                                        viewModel.selectedClothingIDs.removeAll { $0 == clothing.id }
                                    } else {
                                        viewModel.selectedClothingIDs.append(clothing.id ?? "")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    Button("Crear Outfit") {
                        viewModel.enviarOutfit(viewModel: closetViewModel)
                    }


                    .frame(width: 200, height: 40)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()

                }
                .padding(.bottom, 40)
            }
        }
        .alert(isPresented: $viewModel.showSuccessPopup) {
            Alert(
                title: Text("Outfit creado"),
                message: Text("Tu outfit ha sido creado exitosamente."),
                dismissButton: .default(Text("OK")) {
                    selectedTab = 3
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }

    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var selectedClothingIDs: [String] = []
        @State var outfitName: String = ""
        @State var selectedTab: Int = 1

        var body: some View {
            CreateOutfitView(
                selectedTab: $selectedTab,
                closetViewModel: ClosetViewModelMock2() // este es el nombre correcto
            )

        }
    }

    return PreviewWrapper()
}


