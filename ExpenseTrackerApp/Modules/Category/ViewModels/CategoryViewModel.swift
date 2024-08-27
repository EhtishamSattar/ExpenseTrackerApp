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
        if expense.hasExpense(category) {
            self.selectedCategory = category
            self.showDeleteCategoryAlert = true
        }else {
            
            if let index = expense.categories.firstIndex(of: category){
                expense.categories.remove(at: index)
            }
            selectedCategory = nil
        }
        
        
    }
    
    func deleteCategoryWithExpenses() {
        expense.deleteExpense(self.selectedCategory)
        selectedCategory = nil
    }
}
