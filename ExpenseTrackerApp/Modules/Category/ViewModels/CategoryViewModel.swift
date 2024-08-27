//
//  CategoryViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import Foundation

class CategoryViewModel : ObservableObject {
    
    @Published var expense : ExpenseTrackerViewModel
    @Published var showDeleteCategoryAlert = false
    
    var selectedCategory : Category?
    
    init(expense: ExpenseTrackerViewModel){
        self.expense = expense
    }
    
    func addCategory(_ category: Category) {
        expense.addNewCategory(category)
    }
    
    func hasExpenses(for category: Category) -> Bool {
        return expense.hasExpense(category)
    }
    
    
    func deleteCategory(_ category: Category) {
        expense.deleteExpense(category)
        selectedCategory = nil
    }
    
}
