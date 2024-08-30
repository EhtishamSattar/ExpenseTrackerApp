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
    @Published var selectedSortOption: SortOption = .none
    @Published var selectedExpense: Expense? = nil
    @Published var expenseToDeleteEdit: Expense?
    @Published var navigateToEditView: Expense? = nil
    
    @Published var selectedFilterOption : FilterOptions = .none
    @Published var selectedCategoryFilter : String = "none"
    @Published var startDate : Date = Date()
    @Published var endDate : Date = Date()
    @Published var minAmount : String = ""
    @Published var maxAmount : String = ""
    
    
    var alertMessage : String = ""
    let db = UserDefaultsManager.shared
    
    init() {
        fetchDataFromDB()
        
    }
    
    func fetchDataFromDB() {
        let expense = db.loadData()
        self.expenses = expense.expenses
        self.categories = expense.categories
    }
    
    func hasExpense(_ category  : Category) -> Bool{
        return self.expenses.contains { $0.expenseCategory == category.name }
    }
    
    func addNewCategory(_ category  : Category) -> Bool {
        
        var categoryAdded : Bool = false
        let hasCategory = categories.contains { cat in
            return cat == category
        }
        
        if !hasCategory {
            self.categories.append(category)
            self.db.saveData(expenses: expenses, categories: categories)
            categoryAdded = true
        }
        return categoryAdded
    }
    
    func deleteExpenseOfCategory(_ category  : Category?){
        if let ctg = category {
            if let index = self.categories.firstIndex(of: ctg) {
                self.categories.remove(at: index)
                self.expenses.removeAll { $0.expenseCategory == ctg.name }
                self.db.saveData(expenses: expenses, categories: categories)
            }
            //self.db.saveData(expenses: expenses, categories: categories)
        }
        
    }
    
    func findExpense(_ expense: Expense) -> Expense
    {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            return expenses[index]
        }
        return expense
        
    }
    
    func addExpense(_ expense: Expense) {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            expenses[index] = expense
        } else {
            expenses.append(expense)
        }
        self.db.saveData(expenses: expenses, categories: categories)
    }
    
    
    
    func toggleStarred(for expense: Expense) -> Bool {
        var star : Bool = false
        if let index = expenses.firstIndex(of: expense) {
            expenses[index].expenseIsStarred.toggle()
            star = expenses[index].expenseIsStarred
            self.db.saveData(expenses: expenses, categories: categories)
        }
        return star
        
    }
    
    func isStarred(for expense: Expense) -> Bool{
        if let index = expenses.firstIndex(of: expense) {
            return expenses[index].expenseIsStarred
        }
        return false
    }
    
    func starExpense(expense: Expense,newValue: Expense?) {
        if newValue?.id == expense.id {
            if let selExp = newValue {
                if let index = expenses.firstIndex(of: expense) {
                    expenses[index] = selExp
                }
            }
            self.db.saveData(expenses: expenses, categories: categories)
        }
    }
    
    func deleteExpense(expense : Expense?) {
        guard let exp = expense, let index = expenses.firstIndex(of: exp) else {
            return
        }
        expenses.remove(at: index)
        self.db.saveData(expenses: expenses, categories: categories)
    }
    
    
    func applySorting() {
        switch selectedSortOption {
        case .none:
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
    
    func updateSorting(_ newSortOption: SortOption) {
        selectedSortOption = newSortOption
        applySorting()
    }
    
    func applyFiltering(){
        switch selectedFilterOption {
        case .none:
            fetchDataFromDB()
        case .date:
            print("In date filter")
            //getDateRange(startDate: startDate, endDate: endDate)
            fetchDataFromDB()
            expenses = getExpensesInDatesRange(start: self.startDate, end: self.endDate)
        case .category:
            print("In Category")
            fetchDataFromDB()
            if selectedCategoryFilter != "none"{
                expenses = getExpensesforACategory()
                print(expenses)
            }
        case .amount:
            print("In amount filter")
            fetchDataFromDB()
            expenses = getExpensesInAmountRange()
        }
    }
    
    func updateFiltering(_ newFilterOption: FilterOptions){
        selectedFilterOption = newFilterOption
        applyFiltering()
    }
    
    func getDateRange(startDate: Date, endDate: Date){
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func getExpensesforACategory() -> [Expense] {
        var categoryViseExpenses : [Expense] = []
        //print(selectedCategoryFilter!)
        for (_ , exp ) in expenses.enumerated(){
            print("In loop")
            if exp.expenseCategory == selectedCategoryFilter {
                categoryViseExpenses.append(exp)
            }
        }
        //selectedCategoryFilter = nil
        return categoryViseExpenses
    }
    
    func getExpensesInDatesRange(start: Date , end: Date) -> [Expense]{
        var expensesInDateRange : [Expense] = []
        print(start,end)
        for (_, exp) in expenses.enumerated() {
            print("In date ranges loop")
            if exp.expenseDateTime >= start && exp.expenseDateTime <= end {
                expensesInDateRange.append(exp)
            }
            
        }
        print(expensesInDateRange)
        
        return expensesInDateRange
    }
    
    func getExpensesInAmountRange() -> [Expense] {
        
        var expensesInAmountRange : [Expense] = []
        if let min = Double(minAmount) , let max = Double(maxAmount){
            for (_ , exp) in expenses.enumerated() {
                if exp.expenseAmount >= min && exp.expenseAmount <= max {
                    expensesInAmountRange.append(exp)
                }
            }
        }
        
        return expensesInAmountRange
        
    }
    
    func checkDataisReady(expense: Expense) -> Bool {
        guard !expense.expenseName.isEmpty else {
            return false
        }
        
        guard !expense.expenseCategory.isEmpty else {
            return false
        }
        
        if expense.expenseAmount <= 0 {
            alertMessage = "Please enter a valid amount"
            return false
        }
        return true
    }
    
    func calculateTotalExpenseAmount() -> Double {
        return expenses.reduce(0) { (result, expense) in
            result + expense.expenseAmount
        }
    }
}
