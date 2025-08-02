//
//  ImagePicker.swift
//  Outfiter
//
//  Created by Macky on 1/08/25.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                // 🔧 Aplica crop centrado
                //                parent.image = uiImage.cropToSquare()
                parent.image = uiImage.cropToSquare(from: .left)
                
            }
            
            picker.dismiss(animated: true)
        }
        
        // Recorta la imagen al centro en una relación 1:1
        func cropToSquare(image: UIImage) -> UIImage {
            let originalWidth  = image.size.width
            let originalHeight = image.size.height
            
            let squareLength = min(originalWidth, originalHeight)
            let x = (originalWidth - squareLength) / 2.0
            let y = (originalHeight - squareLength) / 2.0
            
            let cropRect = CGRect(x: x, y: y, width: squareLength, height: squareLength)
            
            if let cgImage = image.cgImage?.cropping(to: cropRect) {
                return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
            } else {
                return image // fallback
            }
        }
        
        //        func imagePickerController(_ picker: UIImagePickerController,
        //                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        //            if let uiImage = info[.originalImage] as? UIImage {
        //                parent.image = uiImage
        //            }
        //
        //            picker.dismiss(animated: true)
        //        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


import UIKit

extension UIImage {
    func cropToSquare() -> UIImage? {
        let originalWidth  = self.size.width
        let originalHeight = self.size.height
        
        let sideLength = min(originalWidth, originalHeight)
        
        let originX = (originalWidth - sideLength) / 2.0
        let originY = (originalHeight - sideLength) / 2.0
        
        let cropRect = CGRect(x: originX, y: originY, width: sideLength, height: sideLength)
        guard let cgImage = self.cgImage?.cropping(to: cropRect) else { return nil }
        
        return UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
    }
}

enum CropAlignment {
    case center
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

extension UIImage {
    func cropToSquare(from alignment: CropAlignment = .center) -> UIImage? {
        let originalWidth  = self.size.width
        let originalHeight = self.size.height
        let sideLength = min(originalWidth, originalHeight)
        
        var originX: CGFloat = 0
        var originY: CGFloat = 0
        
        switch alignment {
        case .center:
            originX = (originalWidth - sideLength) / 2
            originY = (originalHeight - sideLength) / 2
        case .top:
            originX = (originalWidth - sideLength) / 2
            originY = 0
        case .bottom:
            originX = (originalWidth - sideLength) / 2
            originY = originalHeight - sideLength
        case .left:
            originX = 0
            originY = (originalHeight - sideLength) / 2
        case .right:
            originX = originalWidth - sideLength
            originY = (originalHeight - sideLength) / 2
        case .topLeft:
            originX = 0
            originY = 0
        case .topRight:
            originX = originalWidth - sideLength
            originY = 0
        case .bottomLeft:
            originX = 0
            originY = originalHeight - sideLength
        case .bottomRight:
            originX = originalWidth - sideLength
            originY = originalHeight - sideLength
        }
        
        let cropRect = CGRect(x: originX, y: originY, width: sideLength, height: sideLength)
        guard let cgImage = self.cgImage?.cropping(to: cropRect) else { return nil }
        
        return UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
    }
}

struct ClothingNameEditor: View {
    @Binding var name: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if name.isEmpty {
                Text("Nombra tu prenda aquí")
                    .foregroundColor(Color.white.opacity(0.6))
                    .padding(.horizontal, 8)
                    .padding(.bottom, 10)
            }
            
            TextEditor(text: $name)
                .frame(width: 180, height: 60)
                .padding(4)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .foregroundColor(.white)
                .font(.headline)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.6)
                .cornerRadius(8)
                .scrollContentBackground(.hidden)
        }
        .frame(width: 180, height: 60)
    }
}
