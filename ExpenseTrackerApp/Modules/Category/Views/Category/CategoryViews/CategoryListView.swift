//
//  CategoryListView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import SwiftUI

struct CategoryListView: View {
    @ObservedObject var expenseTracker : CategoryViewModel // Instantiating an instance of Category View Model class
    @State var showDeleteCategoryAlert : Bool = false
    @State var categoryToDelete: Category?
    
    var body: some View {
        List {
            ForEach(expenseTracker.expense.categories, id: \.self) { category in
                Text("\(category.name)")
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete") {
                            if expenseTracker.hasExpenses(for: category) {
                                categoryToDelete = category
                                showDeleteCategoryAlert = true
                            } else {
                                expenseTracker.deleteCategory(category)
                            }
                        }
                        .tint(.red)
                    }
            }
        }
        .alert(isPresented: $showDeleteCategoryAlert) {
            Alert(
                title: Text("Confirm Delete"),
                message: Text("This category has associated expenses. Are you sure you want to delete it?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let category = categoryToDelete {
                        expenseTracker.deleteCategory(category)
                    }
                },
                secondaryButton: .cancel()
            )
        }

    }
}

#Preview {
    CategoryListView(expenseTracker: CategoryViewModel(expense: ExpenseTrackerViewModel()))
}
