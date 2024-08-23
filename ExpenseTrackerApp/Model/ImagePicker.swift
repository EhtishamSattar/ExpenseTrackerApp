import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var selectedImageData: Data?
    @Binding var savedImageURL: URL?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
                parent.selectedImageData = uiImage.jpegData(compressionQuality: 1.0)
                parent.saveImageToDocumentsDirectory(uiImage)
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    private func saveImageToDocumentsDirectory(_ image: UIImage) {
        do {
            guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
            let fileManager = FileManager.default
            guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let savedURL = documentsDirectory.appendingPathComponent("savedImage.jpg")
            try imageData.write(to: savedURL)
            DispatchQueue.main.async {
                self.savedImageURL = savedURL
            }
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
}
