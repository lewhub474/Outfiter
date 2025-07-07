//
//  Recycling.swift
//  Outfiter
//
//  Created by Macky on 5/07/25.
//


//                            if viewModel.isLoading {
//                                SwiftUI.Color.black.opacity(0.2).ignoresSafeArea()
//                                ProgressView("Cargando...")
//                                    .padding()
//                                    .background(.ultraThinMaterial)
//                                    .cornerRadius(12)
//                            }
                        
//                        } // VStack


//MARK: ANTIGUA LISTA DE CELDA

//struct ClothingListView: View {
//    let garments: [Garments]
//
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns, spacing: 9) {
//                ForEach(garments) { garment in
//                    NavigationLink(destination: OutfitsForClothingView(clothing: garment)) {
//                        ClothingCard2(garment: garment)
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                }
//            }
//            .padding(15)
////        }.background(.ultraThinMaterial)
//    }.background(.black)
//
//    }
//}

// MARK: ANTIGUO CUSTOM TEXFIELD SEARCH

//import SwiftUI
//
//struct CustomTextField: View {
//    var placeholder: String
//    @Binding var text: String
//
//    var body: some View {
//        TextField(placeholder, text: $text)
//            .padding(10)
//            .background(Color.white)
//            .cornerRadius(8)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.black, lineWidth: 1)
//            )
//    }
//}

//MARK: OTRO CUSTOM TEXTFIELD
//
//import SwiftUI
//
//struct CustomTextField2: View {
//    var placeholder: String
//    @Binding var text: String
//    var onSearch: () -> Void = {}
//
//    var body: some View {
//        HStack {
//            TextField(placeholder, text: $text)
//                .padding(10)
//
//            Button(action: onSearch) {
//                Image(systemName: "magnifyingglass.circle.fill")
//                    .foregroundColor(.black)
//                    .font(.system(size: 20))
//            }
//            .padding(.trailing, 10)
//        }
//        .background(Color.white)
//        .cornerRadius(8)
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.black, lineWidth: 1)
//        )
//    }
//}


// MARK: BUSCAR DATA MANEJO DE ERRORES anterior 
//func buscarData() async -> [Garments]? {
//    guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings") else {
//        print("Url invalida")
//        return nil
//    }
//    
//    do {
//        let (data, _) = try await URLSession.shared.data(from: url)
//        
//        // 🔍 Imprime el JSON crudo recibido del backend
//        if let rawJSON = String(data: data, encoding: .utf8) {
//            print("📥 JSON crudo recibido:\n\(rawJSON)")
//        }
//
//        // 🔄 Decodifica el JSON
//        let decodedResponse = try JSONDecoder().decode([Garments].self, from: data)
//        return decodedResponse
//    }
//    catch {
//        print("❌ Error al decodificar el JSON: \(error)")
//    }
//  
//    return nil
//}

//MARK: OPCIONES DE CLOTHING CARD

//struct ClothingCard: View {
//    let garment: Garments
//    @EnvironmentObject var viewModel: ClosetViewModel  // Accede al ViewModel
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//
////            VStack(alignment: .leading, spacing: 4) {
//
//
////                Text("Categoría: \(garment.category?.category ?? "Desconocida")")
////                    .font(.subheadline)
////                    .foregroundColor(.black.opacity(0.9))
////
////                Text("Color: \(garment.color?.color ?? "Desconocido")")
////                    .font(.caption)
////                    .foregroundColor(.black.opacity(0.7))
////            }
////            .padding(.horizontal, 6)
//            AsyncImage(url: URL(string: garment.imgURL ?? ""))
//                        { phase in
//                switch phase {
//                case .success(let image):
//                    image
//                        .resizable()
//                        .aspectRatio(1, contentMode: .fill)
//                        .frame(width: 160, height: 160)
//                        .clipped()
////                        .cornerRadius(12)
//                default:
//                    Rectangle()
//                        .fill(SwiftUI.Color.gray.opacity(0.3))
//                        .frame(width: 160, height: 160)
////                        .cornerRadius(12)
//                }
//            }
//
//
//
//            Text(garment.name ?? "Sin nombre")
//                .font(.headline)
//                .foregroundColor(.black)
//                .multilineTextAlignment(.leading)
//                .lineLimit(3)
//                .minimumScaleFactor(0.8)
//
//
//
//
//            // Botón para eliminar la prenda
//            Button(action: {
//                Task {
//                    if let index = viewModel.datosModelo.firstIndex(where: { $0.id == garment.id }) {
//                        // Muestra loading
//                        viewModel.isLoading = true
//                        let success = await viewModel.deletePost(at: index)
//                            await viewModel.getPosts()
//                        viewModel.isLoading = false
//                    }
//                }
//            }) {
//                Image(systemName: "trash")
//                    .foregroundColor(.black)
//                    .padding(5)
//                    .background(Circle().fill(.white))
////                    .shadow(radius: 1)
//            }
//            .padding(.top, 5)
//        }
//        .padding()
//        .frame(width: 180, height: 280) // Ajusté la altura para acomodar el botón
////        .background(.ultraThinMaterial)
//        .background(.white)
//        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 4, y: 0)
//
//
////        .cornerRadius(16)
////        .shadow(radius: 1)
//    }
//}

//import SwiftUI
//
//struct ClothingCard: View {
//    let garment: Garments
//    @EnvironmentObject var viewModel: ClosetViewModel
//    
//    var body: some View {
//        ZStack(alignment: .bottomTrailing) {
//            
//            // Fondo tipo polaroid con sombra
//            Rectangle()
//                .fill(Color.white)
//                .frame(width: 180, height: 240)
//            //                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 4, y: 4)
//            
//            VStack(spacing: 8) {
//                // Imagen con borde superior y laterales
//                AsyncImage(url: URL(string: garment.imgURL ?? "")) { phase in
//                    switch phase {
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 152, height: 152)
//                            .clipped()
//                        //                            .cornerRadius(4)
//                    default:
//                        Rectangle()
//                            .fill(Color.gray.opacity(0.3))
//                            .frame(width: 152, height: 152)
//                        //                            .cornerRadius(4)
//                    }
//                }
//                
//                // Nombre alineado al borde izquierdo de la imagen
//                Text(garment.name ?? "Sin nombre")
//                    .font(.headline)
//                    .foregroundColor(.black)
//                    .lineLimit(nil) // sin límite de líneas
//                    .minimumScaleFactor(0.6)
//                    .multilineTextAlignment(.leading)
//                    .frame(width: 155, alignment: .leading)
//                
//                
//                Spacer(minLength: 0)
//            }
//            .padding(.top, 12)
//            .padding(.bottom, 28)
//            .frame(width: 180, height: 240)
//            
//            // Botón flotante
//            Button(action: {
//                Task {
//                    if let index = viewModel.datosModelo.firstIndex(where: { $0.id == garment.id }) {
//                        viewModel.isLoading = true
//                        let _ = await viewModel.deletePost(at: index)
//                        await viewModel.getPosts()
//                        viewModel.isLoading = false
//                    }
//                }
//            }) {
//                Image(systemName: "trash")
//                    .foregroundColor(.black)
//                    .padding(6)
//                    .background(Circle().fill(Color.white))
//            }
//            .padding(10)
//        } .cornerRadius(8)
//        //        .frame(width: 180, height: 240)
//    }
//}
//
//
//#Preview {
//    let sampleGarment = Garments(
//        id: "",
//        name: "Camiseta",
//        category: Category(id: "", category: "Accesorios", image_url: ""),
//        color: ColorClothes(id: "", color: "Amarillo"),
//        imgURL: ""
//    )
//    
//    let viewModel = ClosetViewModel()
//    
//    return ZStack {
//        Color.gray.opacity(0.2).ignoresSafeArea()  // Fondo gris pantalla completa
//        
//        ClothingCard(garment: sampleGarment)
//            .environmentObject(viewModel)
//    }
//}
//


//MARK: Antigua version de ClosetView sin header colapsable

//struct ClosetView: View {
//    @State private var showPostDataInput = false
//    @State private var name = ""
//    @State private var selectedCategory = "64ca77d45cf35ef21b7ece5a"
//    @State private var selectedColor = "64ca772f5cf35ef21b7ece41"
//    @State private var creatorOutfits = false
//    @State private var showOutfits = false
//    @State private var selectedClothingIDs: [String] = []
//    @State private var outfitName = ""
//    @StateObject var viewModel = ClosetViewModel()  // ViewModel
//    @State private var selectedClothing: Garments? = nil
//    @State private var showImageUploader = false
//    @State private var uploadedImageURL: String? = nil
//    @State private var showAddClothingWithImage = false
//    @State private var showSideMenu = false
//    @State private var textSearch = ""
//
//
//    var body: some View {
//        NavigationView {
//
//            ZStack {
//                Color.black
//                    .ignoresSafeArea()
//
//                VStack{
//
//                }
////                VStack {
////
////                    TopBarView2(showSideMenu: $showSideMenu, userName: "Lewis Ferreira", profileImage:   Image("tendativa_banner"))
////
////                    StoryTabBar(stories: [
////                        StoryItem(
////                            image: Image("tendativa_banner"),
////                            label: "Favoritos",
////                            borderColor: .green,
////                            action: { print("Favoritos") }
////                        ),
////                        StoryItem(
////                            image: Image("jacket.image"),
////                            label: "Camisetas",
////                            borderColor: .purple,
////                            action: { print("Camisetas") }
////                        ),
////                        StoryItem(
////                            image: Image("pants.image"),
////                            label: "Pantalones",
////                            borderColor: .orange,
////                            action: { print("Pantalones") }
////                        ),
////                        StoryItem(
////                            image: Image( "headphones.image"),
////                            label: "Accesorios",
////                            borderColor: .gray,
////                            action: { print("Accesorios") }
////                        )
////                    ])
////
////                    //                        .padding(.vertical, 30)
////                    //                    CustomTextField(placeholder: "Encuentra", text: $textSearch)
////                    //                        .padding(.horizontal, 15)
////                    //                        .padding(.vertical, 5)
////
////                    ZStack {
////                        ClothingListView(garments: viewModel.datosModelo) .ignoresSafeArea()
////                            .blur(radius: viewModel.isLoading ? 3 : 0)
////                            .disabled(viewModel.isLoading)
////                        //                        VStack {
////                        if viewModel.isLoading {
////
////                            ZStack {
////                                SwiftUI.Color.black.opacity(0.4).ignoresSafeArea()
////
////                                GIFView(gifName: "TDTV_loading")
////                                    .frame(width: 150, height: 150)
////                                    .clipShape(RoundedRectangle(cornerRadius: 12))
////                            }.onAppear {
////                                viewModel.printseñal()
////                            }
////                        }
////
////                        if let error = viewModel.errorMessage {
////                            ZStack {
////                                Color.black.opacity(0.6).ignoresSafeArea()
////                                VStack(spacing: 16) {
////                                    GIFView(gifName: "TDTV_loading") // Puedes usar uno distinto para errores
////                                        .frame(width: 150, height: 150)
////                                    Text(error)
////                                        .foregroundColor(.white)
////                                        .multilineTextAlignment(.center)
////                                        .padding(.horizontal)
////                                }
////                            }
////                        }
////
////                        if showSideMenu {
////                            SideMenuView()
////                                .transition(.move(edge: .leading))
////                                .zIndex(1)
////                        }
////                    }
////
////                }
//            }
//        }
//        .ignoresSafeArea(.keyboard)
//
//
//        .task {
//            await viewModel.getPosts()
//        }
//        .sheet(isPresented: $showPostDataInput) {
//            AddClothingView(
//                name: $name,
//                selectedCategory: $selectedCategory,
//                selectedColor: $selectedColor
//            )
//            .onDisappear {
//                Task {
//                    await viewModel.getPosts()
//                }
//            }
//        }
//
//        .sheet(isPresented: $showOutfits) {
//            ViewerOutfits()
//        }
//        .sheet(isPresented: $showAddClothingWithImage) {
//            AddClothingUploadImage(
//                name: $name,
//                selectedCategory: $selectedCategory,
//                selectedColor: $selectedColor
//            )
//            .onDisappear {
//                Task {
//                    await viewModel.getPosts()
//                }
//            }
//        }
//        .environmentObject(viewModel)
//    }
//}
