//
//  Picker.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import SwiftUI

struct PickerView: View {
    @Binding var selectedText : String
    @ObservedObject var expenseTracker : ExpenseTrackerViewModel
    var body: some View {
        Picker("", selection: $selectedText) {
            if expenseTracker.categories.isEmpty {
                Image(systemName: "error.fil")
            }else{
                ForEach(expenseTracker.categories, id: \.self) { category in
                    
                    Text(category.name)
                        .tag(category.name)
                        .foregroundColor(.black)
                    
                }
            }
            
            
        }
        .accentColor(Color("ThemeColor"))
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("ThemeColor"), lineWidth: 1)
        )
    }
}

#Preview {
    PickerView(selectedText: Binding.constant("Preview"), expenseTracker: ExpenseTrackerViewModel())
}
