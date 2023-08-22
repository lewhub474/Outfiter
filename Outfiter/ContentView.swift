//
//  ContentView.swift
//  Outfiter
//
//  Created by Macky on 7/08/23.
//
import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject var postProvider = NetworkingProviderPOST()
    @State private var postResponse: String?
    @StateObject var viewModel = PostViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.datosModelo, id: \.id) {posts in
                Text(posts.name ?? "Nil")
            }.task {
                await viewModel.getPosts()
            }
            Text("Respuesta POST: \(postResponse ?? "")")
            
            Button("Enviar POST") {
                enviarPOST()
            }
            .padding()
        }
    }
    
    private func enviarPOST() {
        Task {
            if let response = await postProvider.enviarPost() {
                postResponse = response
              await  viewModel.getPosts()
            } else {
                postResponse = "Error al enviar POST"
            }
        }
    }
}

class NetworkingProvider: ObservableObject {
    func buscarData() async -> [Outfit]? {
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings") else {
            print("Url invalida")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([Outfit].self, from: data) {
                return decodedResponse
            }
        }
        
        catch {
            print("Ops!")
        }
      
        return nil
    }
    
}

struct Outfit: Codable, Identifiable {
    let id: String?
    let name: String?
    let category: Category?
    let color: Color?
    let imgURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, category, color
        case imgURL = "img_url"
    }
}

struct Category: Codable {
    let id: String?
    let name: String?
}

struct Color: Codable {
    let id: String?
    let name: String?
}


//struct Modelo: Codable {
//    var id: Int
//    var name: String
//}

final class PostViewModel: ObservableObject {
    @Published var datosModelo = [Outfit]()
    private var provider = NetworkingProvider()
    
    @MainActor func getPosts() async {
        self.datosModelo = await provider.buscarData() ?? []
    }
}

class NetworkingProviderPOST: ObservableObject {
    func enviarPost() async -> String? {
        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/clothings/") else {
            print("URL inválida")
            return nil
        }
        
        let body: [String: Any] = [
            "name": "Subido3",
            "category": "64ca77d45cf35ef21b7ece5a",
            "color": "64ca772f5cf35ef21b7ece41"
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let (data, _) = try await URLSession.shared.data(for: request)
            if let responseMessage = String(data: data, encoding: .utf8) {
                return responseMessage
            }
        } catch {
            print("Error al enviar POST: \(error)")
        }
        
        return nil
    }
}
