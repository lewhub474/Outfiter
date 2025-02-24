//
//  OutfitViewModel.swift
//  Outfiter
//
//  Created by Macky on 21/02/25.
//

import Foundation

class OutfitViewModel: ObservableObject {
    @Published var outfits = [DatabaseOutfits]()
    
    private let getOutfitsUseCase: GetOutfitsUseCaseProtocol
    private let deleteOutfitUseCase: DeleteOutfitUseCaseProtocol
    
    init(getOutfitsUseCase: GetOutfitsUseCaseProtocol = GetOutfitsUseCase(),
         deleteOutfitUseCase: DeleteOutfitUseCaseProtocol = DeleteOutfitUseCase()) {
        self.getOutfitsUseCase = getOutfitsUseCase
        self.deleteOutfitUseCase = deleteOutfitUseCase
    }

    func getOutfits() {
        Task {
            do {
                let fetchedOutfits = try await getOutfitsUseCase.execute()
                DispatchQueue.main.async { [weak self] in
                    self?.outfits = fetchedOutfits
                }
            } catch {
                print("Error al obtener los outfits: \(error)")
            }
        }
    }
    
    func deleteOutfit(at outfitID: String) {
        Task {
            do {
                try await deleteOutfitUseCase.execute(outfitID: outfitID)
                DispatchQueue.main.async { [weak self] in
                    self?.outfits.removeAll { $0.id == outfitID }
                }
            } catch {
                print("Error al eliminar el outfit: \(error)")
            }
        }
    }
}


//class OutfitViewModel: ObservableObject {
//    @Published var outfits = [DatabaseOutfits]()
//    
//    
//    func getOutfitsFromAPI() {
//        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/outfits") else {
//            print("URL inválida")
//            return
//        }
//        
//        Task {
//            do {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                let decoder = JSONDecoder()
//                let decodedOutfits = try decoder.decode([DatabaseOutfits].self, from: data)
//                DispatchQueue.main.async { [self] in
//                    outfits = decodedOutfits
//                }
//            } catch {
//                print("Error al obtener los outfits: \(error)")
//            }
//        }
//    }
//
//    
//}
//
//
//extension OutfitViewModel {
//    func deleteOutfit(at outfitID: String) {
//        Task {
//            if let response = await deleteOutfitFromAPI(outfitID: outfitID) {
//                if response == "Outfit eliminado" {
//                    // Elimina el outfit eliminado de los datos locales
//                    outfits.removeAll { $0.id == outfitID }
//                }
//            }
//        }
//    }
//    
//    private func deleteOutfitFromAPI(outfitID: String) async -> String? {
//        guard let url = URL(string: "https://backend-ot4e.onrender.com/api/outfits/\(outfitID)") else {
//            print("URL inválida")
//            return nil
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//
//        do {
//            let (_, response) = try await URLSession.shared.data(for: request)
//            if let httpResponse = response as? HTTPURLResponse {
//                if httpResponse.statusCode == 204 {
//                    return "Outfit eliminado"
//                }
//            }
//        } catch {
//            print("Error al eliminar el outfit: \(error)")
//        }
//
//        return nil
//    }
//}
//
