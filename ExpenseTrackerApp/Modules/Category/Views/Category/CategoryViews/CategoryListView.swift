//
//  CategoryListView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import SwiftUI

struct CategoryListView: View {
    
    @ObservedObject var categoryTracker : CategoryViewModel // Instantiating an instance of Category View Model class
    
    var body: some View {
        List {
            ForEach(categoryTracker.expense.categories, id: \.self) { category in
                Text("\(category.name)")
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        CategoryDeleteButton(categoryTracker: categoryTracker, placeholderText: "Delete", categoryToDelete: category)
                    }
            }
        }
        .alert(isPresented: $categoryTracker.showDeleteCategoryAlert) {
            Alert(
                title: Text("Confirm Delete"),
                message: Text("This category has associated expenses. Are you sure you want to delete it?"),
                primaryButton: .destructive(Text("Delete")) {
                    categoryTracker.deleteCategoryWithExpenses()
                },
                secondaryButton: .cancel()
            )
        }

    }
}

#Preview {
    CategoryListView(categoryTracker: CategoryViewModel(expense: ExpenseTrackerViewModel()))
}
