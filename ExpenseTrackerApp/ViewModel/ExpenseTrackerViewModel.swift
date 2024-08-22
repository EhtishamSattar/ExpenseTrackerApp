//
//  ExpenseTrackerViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//

import Foundation
import Combine

class ExpenseTrackerViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var categories: [Category] = []
    
    private let userDefaultsKey = "expenseTrackerData"
    
    init() {
        loadData()
    }
    
    // Load data from UserDefaults
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            let decoder = JSONDecoder()
            do {
                let expenseTrackerData = try decoder.decode(ExpenseTrackerData.self, from: data)
                self.expenses = expenseTrackerData.expenses
                self.categories = expenseTrackerData.categories
            } catch {
                print("Failed to decode expense tracker data: \(error)")
            }
        }
    }
    
    // Save data to UserDefaults
    func saveData() {
        let encoder = JSONEncoder()
        let expenseTrackerData = ExpenseTrackerData(expenses: expenses, categories: categories)
        do {
            let encodedData = try encoder.encode(expenseTrackerData)
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        } catch {
            print("Failed to encode expense tracker data: \(error)")
        }
    }
    
    // Example method to add an expense
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        saveData()
    }
    
    // Example method to add a category
    func addCategory(_ category: Category) {
        categories.append(category)
        saveData()
    }
}
