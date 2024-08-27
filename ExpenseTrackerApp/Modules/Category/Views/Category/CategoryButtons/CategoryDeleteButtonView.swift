//
//  CategoryDeleteButton.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 27/08/2024.
//

import SwiftUI

struct CategoryDeleteButton: View {
    @ObservedObject var categoryTracker : CategoryViewModel
    var placeholderText : String
    var categoryToDelete : Category
    
    var body: some View {
        VStack{
            Button("\(placeholderText)") {
                print("Delete Button : \(categoryTracker.hasExpenses(for: categoryToDelete))")
                categoryTracker.deleteCategory(categoryToDelete)
            }
            .tint(.red)
            
        }

    }
}

#Preview {
    CategoryDeleteButton(categoryTracker: CategoryViewModel(expense: ExpenseTrackerViewModel()),placeholderText: "Delete", categoryToDelete: Category())
}
