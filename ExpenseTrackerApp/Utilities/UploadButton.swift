//
//  UploadButton.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 23/08/2024.
//

import SwiftUI

struct UploadButton: View {
    @State private var isFileImporterPresented = false
    @State private var selectedImage: Image? = nil
    @State private var selectedImageData: Data? = nil
    @State private var savedImageURL: URL? = nil

    var body: some View {
        VStack {
            Button(action: {
                isFileImporterPresented = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color("ThemeColor"))
                    .padding(10)
                    .background(Circle().fill(Color.white))
                    .shadow(radius: 5)
            }
            .fileImporter(
                isPresented: $isFileImporterPresented,
                allowedContentTypes: [.image],
                onCompletion: handleFileImport
            )
            
            selectedImage?
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
            
            if let savedImageURL = savedImageURL {
                Text("Saved Image URL: \(savedImageURL.path)")
                    .font(.caption)
                    .padding()
            }
        }
    }
    
    private func handleFileImport(result: Result<URL, Error>) {
        switch result {
        case .success(let fileURL):
            loadImage(from: fileURL)
            saveImageDataToDocumentsDirectory(from: fileURL)
        case .failure(let error):
            print("Error importing file: \(error.localizedDescription)")
        }
    }
    
    private func loadImage(from url: URL) {
        do {
            let imageData = try Data(contentsOf: url)
            if let uiImage = UIImage(data: imageData) {
                selectedImage = Image(uiImage: uiImage)
                selectedImageData = imageData
            }
        } catch {
            print("Error loading image: \(error.localizedDescription)")
        }
    }
    
    private func saveImageDataToDocumentsDirectory(from fileURL: URL) {
        do {
            let imageData = try Data(contentsOf: fileURL)
            let fileManager = FileManager.default
            guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let savedURL = documentsDirectory.appendingPathComponent(fileURL.lastPathComponent)
            try imageData.write(to: savedURL)
            savedImageURL = savedURL
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
}


//#Preview {
//    HomeView(expenseTracker: ExpenseTrackerViewModel())
//}

#Preview {
    UploadButton()
}
