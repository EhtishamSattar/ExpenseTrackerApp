//
//  AddEditButton.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import SwiftUI

struct AddEditButton: View {
    var page = "Home"
    
    var body: some View {
        Text(page == "Home" ? "Save" : "Edit")
            .foregroundColor(.white)
            .padding()
            .frame(width: 380)
            .background(Color("ThemeColor"))
        
    }
}

#Preview {
    AddEditButton()
}
