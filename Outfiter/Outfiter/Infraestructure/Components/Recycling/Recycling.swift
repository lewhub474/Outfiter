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


//import Foundation
//import SwiftUI
//
//final class CreateOutfitViewModel: ObservableObject {
//    @Published var selectedClothingIDs: [String] = []
//    @Published var outfitName: String = ""
//    @Published var showSuccessPopup: Bool = false
//    @Published var showValidationAlert: Bool = false
//    @Published var validationMessage: String = ""
//
//    let postProvider = NetworkingProviderOutfit()
//
//    func enviarOutfit(viewModel: ClosetViewModel, completion: @escaping () -> Void) {
//        guard !selectedClothingIDs.isEmpty else {
//            validationMessage = "Debes seleccionar al menos una prenda."
//            showValidationAlert = true
//            return
//        }
//
//        guard !outfitName.isEmpty else {
//            validationMessage = "Debes ingresar un nombre para el outfit."
//            showValidationAlert = true
//            return
//        }
//
//        let validIDs = viewModel.datosModelo.compactMap { $0.id }
//        let invalidIDs = selectedClothingIDs.filter { !validIDs.contains($0) }
//
//        if !invalidIDs.isEmpty {
//            validationMessage = "IDs de prendas inválidos: \(invalidIDs.joined(separator: ", "))"
//            showValidationAlert = true
//            return
//        }
//
//        let body: [String: Any] = [
//            "name": outfitName,
//            "clothings": selectedClothingIDs
//        ]
//
//        Task {
//            if let response = await postProvider.enviarPost(body: body) {
//                print("Outfit creado: \(response)")
//                selectedClothingIDs.removeAll()
//                outfitName = ""
//                showSuccessPopup = true
//                completion()
//            } else {
//                validationMessage = "Error al crear el outfit."
//                showValidationAlert = true
//            }
//        }
//    }
//}
//
//struct CreateOutfitView: View {
//    @Binding var selectedTab: Int
//    @ObservedObject var viewModel: ClosetViewModel
//    @StateObject private var outfitViewModel = CreateOutfitViewModel()
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                VStack {
//                    Text("Dressing Room")
//                        .font(.title)
//                        .bold()
//                        .padding(.top, 20)
//
//                    Text("Selecciona las prendas para tu outfit:")
//                        .font(.title3)
//                        .foregroundColor(.gray)
//
//                    TextField("Nombre del outfit", text: $outfitViewModel.outfitName)
//                        .padding(10)
//                        .background(.white)
//                        .cornerRadius(8)
//                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1))
//                        .padding()
//
//                    ScrollView {
//                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 12)], spacing: 12) {
//                            ForEach(viewModel.datosModelo) { clothing in
//                                let isSelected = outfitViewModel.selectedClothingIDs.contains(clothing.id ?? "")
//                                SelectableClothingCard(garment: clothing, isSelected: isSelected) {
//                                    if isSelected {
//                                        outfitViewModel.selectedClothingIDs.removeAll { $0 == clothing.id }
//                                    } else {
//                                        outfitViewModel.selectedClothingIDs.append(clothing.id ?? "")
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//
//                    Button("Crear Outfit") {
//                        outfitViewModel.enviarOutfit(viewModel: viewModel) {
//                            presentationMode.wrappedValue.dismiss()
//                        }
//                    }
//                    .frame(width: 200, height: 40)
//                    .background(.black)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//                    .padding()
//
//                }
//                .padding(.bottom, 40)
//            }
//        }
//        .alert(isPresented: $outfitViewModel.showSuccessPopup) {
//            Alert(
//                title: Text("Outfit creado"),
//                message: Text("Tu outfit ha sido creado exitosamente."),
//                dismissButton: .default(Text("OK")) {
//                    selectedTab = 3
//                }
//            )
//        }
//        .alert(isPresented: $outfitViewModel.showValidationAlert) {
//            Alert(
//                title: Text("Validación"),
//                message: Text(outfitViewModel.validationMessage),
//                dismissButton: .default(Text("OK"))
//            )
//        }
//    }
//}
//
//
//#Preview {
//    struct PreviewWrapper: View {
//        @State var selectedTab: Int = 1
//
//        var body: some View {
//            CreateOutfitView(
//                selectedTab: $selectedTab,
//                viewModel: ClosetViewModelMock2()
//            )
//        }
//    }
//
//    return PreviewWrapper()
//}
//
// MARK: CreateOutfitView de antes sin viewmodel

//struct CreateOutfitView: View {
//    @State private var showSuccessPopup = false
//    @Binding var selectedTab: Int // 👈 Para cambiar la vista desde DashboardView
//    @Binding var selectedClothingIDs: [String]
//    @Binding var outfitName: String
//    @State private var outfitResponse: String?
//    @ObservedObject var viewModel: ClosetViewModel
//    let outfits: [Garments]
//    @StateObject var postProvider = NetworkingProviderOutfit()
//    @Environment(\.presentationMode) var presentationMode
//
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                VStack {
//                Text("Dressing Room")
//                    .font(.title)
//                    .bold()
//                    .padding(.top, 20)
//
//                Text("Selecciona las prendas para tu outfit:")
//                    .font(.title3)
//                    .foregroundColor(.gray)
//
//                TextField("Nombre del outfit", text: $outfitName)
//                    .padding(10) // Espaciado interno
//                    .background(.white) // Fondo blanco para que el campo de texto resalte
//                    .cornerRadius(8) // Bordes redondeados
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 8) // Crea un borde alrededor
//                            .stroke(.black, lineWidth: 1) // Color y grosor del borde
//                    ).padding()
//                    ScrollView {
//                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 12)], spacing: 12) {
//                            ForEach(viewModel.datosModelo) { clothing in
//                                let isSelected = selectedClothingIDs.contains(clothing.id ?? "")
//                                SelectableClothingCard(garment: clothing, isSelected: isSelected) {
//                                    if isSelected {
//                                        selectedClothingIDs.removeAll { $0 == clothing.id }
//                                    } else {
//                                        selectedClothingIDs.append(clothing.id ?? "")
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//
//
//
//                Button(action: {
//                    enviarOutfit()
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("Crear Outfit")
//                        .frame(width: 200, height: 40)
//                        .background(.black)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding()
//
//                }   .padding(.bottom, 40)
//            }
//        }.alert(isPresented: $showSuccessPopup) {
//            Alert(
//                title: Text("Outfit creado"),
//                message: Text("Tu outfit ha sido creado exitosamente."),
//                dismissButton: .default(Text("OK")) {
//                    selectedTab = 3 // 👈 Navega a ViewerOutfits
//                }
//            )
//        }
//
//    }
//    private func enviarOutfit() {
//        // Verifica que haya al menos una prenda seleccionada y un nombre de outfit válido
//        guard !selectedClothingIDs.isEmpty, !outfitName.isEmpty else {
//            outfitResponse = "Debes seleccionar prendas y proporcionar un nombre."
//            return
//        }
//
//        // Verifica que todos los IDs seleccionados sean válidos
//        let invalidIDs = selectedClothingIDs.filter { id in
//            return !viewModel.datosModelo.contains { clothing in
//                return clothing.id == id
//            }
//        }
//
//
//        if !invalidIDs.isEmpty {
//            outfitResponse = "IDs de prendas inválidos: \(invalidIDs.joined(separator: ", "))"
//            return
//        }
//
//
//        let selectedClothingDetails: [[String: Any]] = viewModel.datosModelo
//                .filter { selectedClothingIDs.contains($0.id ?? "") }
//                .map { clothing in
//                    var clothingDetails = [String: Any]()
//                    clothingDetails["id"] = clothing.id
//                    clothingDetails["name"] = clothing.name
//                    clothingDetails["category"] = clothing.category?.category
//                    clothingDetails["color"] = clothing.color?.color
//                    return clothingDetails
//                }
//        // Los IDs son válidos, procede con la creación del outfit
//        let body: [String: Any] = [
//            "name": outfitName,
//            "clothings": selectedClothingIDs
//        ]
//
//        // Obtenemos los nombres de categorías y colores correspondientes a los IDs seleccionados
//        let selectedCategoryNames = viewModel.datosModelo
//            .filter { selectedClothingIDs.contains($0.id ?? "") }
//            .compactMap { $0.category?.category }
//
//        let selectedColorNames = viewModel.datosModelo
//            .filter { selectedClothingIDs.contains($0.id ?? "") }
//            .compactMap { $0.color?.color }
//        let selectedClothingNames = viewModel.datosModelo
//                .filter { selectedClothingIDs.contains($0.id ?? "") }
//                .compactMap { $0.name }
//
//        print("Nombre del Outfit: \(outfitName)")
//        print("Nombres de las prendas seleccionadas: \(selectedClothingNames.joined(separator: ", "))")
//        print("IDs seleccionados de prendas: \(selectedClothingIDs.joined(separator: ", "))")
//        print("Categorías seleccionadas: \(selectedCategoryNames.joined(separator: ", "))")
//        print("Colores seleccionados: \(selectedColorNames.joined(separator: ", "))")
//
//        Task {
//            if let response = await postProvider.enviarPost(body: body) {
//                outfitResponse = response
//                selectedClothingIDs.removeAll()
//                outfitName = ""
//                showSuccessPopup = true // 👈 Mostrar popup
//            } else {
//                outfitResponse = "Error al crear el outfit."
//            }
//
//        }
//    }
//}

// MARK: SelectableClothingCard con letras mas pequeñas

//struct SelectableClothingCard: View {
//    let garment: Garments
//    let isSelected: Bool
//    let onTap: () -> Void
//
//    var body: some View {
//        ZStack(alignment: .topTrailing) {
//            ZStack(alignment: .bottom) {
//                // Imagen principal
//                AsyncImage(url: URL(string: garment.imgURL ?? "")) { phase in
//                    switch phase {
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 180, height: 240)
//                            .clipped()
//                    default:
//                        Rectangle()
//                            .fill(Color.gray.opacity(0.3))
//                            .frame(width: 180, height: 240)
//                    }
//                }
//
//                // Nombre en la parte inferior
//                HStack {
//                    Text(garment.name ?? "Sin nombre")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .lineLimit(2)
//                        .minimumScaleFactor(0.6)
//                        .multilineTextAlignment(.leading)
//
//                    Spacer()
//                }
//                .padding(8)
//                .frame(width: 180)
//                .background(
//                    LinearGradient(
//                        gradient: Gradient(colors: [Color.black.opacity(0.6), .clear]),
//                        startPoint: .bottom,
//                        endPoint: .top
//                    )
//                    .frame(height: 60),
//                    alignment: .bottom
//                )
//            }
//
//            // Checkbox en la esquina superior derecha
//            Button(action: {
//                onTap()
//            }) {
//                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
//                    .foregroundColor(isSelected ? .green : .white)
//                    .font(.title2)
//                    .padding(8)
//                    .background(Circle().fill(Color.black.opacity(0.6)))
//            }
//            .padding(8)
//        }
//        .frame(width: 180, height: 240)
//        .cornerRadius(8)
//        .shadow(radius: 2)
//        .clipped()
//    }
//}

//struct SelectableClothingCard: View {
//    let garment: Garments
//    let isSelected: Bool
//    let onTap: () -> Void
//
//    var body: some View {
//        ZStack(alignment: .topTrailing) {
//            AsyncImage(url: URL(string: garment.imgURL ?? "")) { phase in
//                switch phase {
//                case .success(let image):
//                    image
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 160, height: 200)
//                        .clipped()
//                default:
//                    Rectangle()
//                        .fill(Color.gray.opacity(0.3))
//                        .frame(width: 160, height: 200)
//                }
//            }
//
//            // Checkbox sobre la imagen
//            Button(action: {
//                onTap()
//            }) {
//                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
//                    .foregroundColor(isSelected ? .green : .white)
//                    .font(.title2)
//                    .padding(8)
//                    .background(Circle().fill(Color.black.opacity(0.6)))
//            }
//            .padding(6)
//
//            // Nombre en la parte inferior
//            VStack {
//                Spacer()
//                Text(garment.name ?? "Sin nombre")
//                    .font(.caption)
//                    .bold()
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal, 8)
//                    .padding(.bottom, 6)
//                    .background(
//                        LinearGradient(
//                            gradient: Gradient(colors: [Color.black.opacity(0.7), .clear]),
//                            startPoint: .bottom,
//                            endPoint: .top
//                        )
//                    )
//            }
//        }
//        .frame(width: 160, height: 200)
//        .cornerRadius(10)
//        .shadow(radius: 2)
//    }
//}

//#Preview {
//    SelectableClothingCard(
//        garment: Garments(
//            id: "1",
//            name: "Camiseta blanca",
//            category: nil,
//            color: nil,
//            imgURL: "https://via.placeholder.com/200x300"
//        ),
//        isSelected: true,
//        onTap: {}
//    )
//}
