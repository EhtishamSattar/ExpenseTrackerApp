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
   // @State var showDeleteCategoryAlert = false
   // @State var selectedCategory : Category?
    
    var body: some View {
        VStack{
            Button("\(placeholderText)") {
                print("Delete Button : \(categoryTracker.hasExpenses(for: categoryToDelete))")
                if categoryTracker.hasExpenses(for: categoryToDelete) {
                    categoryTracker.selectedCategory = categoryToDelete
                    categoryTracker.showDeleteCategoryAlert = true
                } else {
                    categoryTracker.deleteCategory(categoryToDelete)
                }
               // print(showDeleteCategoryAlert)
            }
            .tint(.red)
            
        }
//        .alert(isPresented: $showDeleteCategoryAlert) {
//            return Alert(
//                title: Text("Confirm Delete"),
//                message: Text("This category has associated expenses. Are you sure you want to delete it?"),
//                primaryButton: .destructive(Text("Delete")) {
//                    if let selectedToDel = selectedCategory {
//                        categoryTracker.deleteCategory(selectedToDel)
//                    }
//                },
//                secondaryButton: .cancel()
//            )
//        }
    }
}

#Preview {
    CategoryDeleteButton(categoryTracker: CategoryViewModel(expense: ExpenseTrackerViewModel()),placeholderText: "Delete", categoryToDelete: Category())
}
