//
//  CategoryViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import Foundation

class CategoryViewModel : ObservableObject {
    
    @Published var expense : ExpenseTrackerViewModel
    
    init(expense: ExpenseTrackerViewModel){
        self.expense = expense
    }
    
    func addCategory(_ category: Category) {
        expense.categories.append(category)
        expense.saveData()
    }
    
    func hasExpenses(for category: Category) -> Bool {
        return expense.expenses.contains { $0.expenseCategory == category.name }
    }
    
    
    func deleteCategory(_ category: Category) {
        if let index = expense.categories.firstIndex(of: category) {
            expense.categories.remove(at: index)
            expense.expenses.removeAll { $0.expenseCategory == category.name }
            expense.saveData()
        }
    }
    
    
    
    
}
