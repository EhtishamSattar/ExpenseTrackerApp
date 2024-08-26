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
    @Published var selectedFilter: FilterOption = .filter
    @Published var selectedExpense: Expense? = nil
    @Published var expenseToDeleteEdit: Expense?
    @Published var navigateToEditView: Expense? = nil
    
    var alertMessage : String = ""
    
    private let userDefaultsKey = "expenseTrackerData"
    
    init() {
        loadData()
    }
    
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
    
    func addExpense(_ expense: Expense) {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            expenses[index] = expense
        } else {
            expenses.append(expense)
        }
        saveData()
    }
    
    
    
    func toggleStarred(for expense: Expense) -> Bool {
        var star : Bool = false
        if let index = expenses.firstIndex(of: expense) {
            expenses[index].expenseIsStarred.toggle()
            star = expenses[index].expenseIsStarred
            saveData()
            
        }
        return star
        
    }
    
    func isStarred(for expense: Expense) -> Bool{
        if let index = expenses.firstIndex(of: expense) {
            return expenses[index].expenseIsStarred
        }
        return false
    }
    
    
    func deleteExpense(expense : Expense?) {
        guard let exp = expense, let index = expenses.firstIndex(of: exp) else {
            return
        }
        expenses.remove(at: index)
        saveData()
    }
    
    
    func applyFilter() {
        switch selectedFilter {
        case .filter:
            break
        case .aToZ:
            expenses.sort { $0.expenseName < $1.expenseName }
        case .zToA:
            expenses.sort { $0.expenseName > $1.expenseName }
        case .date:
            expenses.sort { $0.expenseDateTime < $1.expenseDateTime }
        case .category:
            expenses.sort { $0.expenseCategory < $1.expenseCategory }
        }
    }
    
    func updateFilter(_ newFilter: FilterOption) {
        selectedFilter = newFilter
        applyFilter()
    }
    
    func checkDataisReady(expense: Expense) -> Bool {
        guard !expense.expenseName.isEmpty else {
            return false
        }
        
        guard !expense.expenseCategory.isEmpty else {
            return false
        }
        
        guard let _ = Double(expense.expenseAmount), !expense.expenseAmount.isEmpty else {
            alertMessage = "Please enter a valid amount"
            return false
        }
        
        return true
    }
    
    func calculateTotalExpenseAmount() -> Double {
        return expenses.reduce(0) { (result, expense) in
            result + (Double(expense.expenseAmount) ?? 0)
        }
    }
    
    
}
